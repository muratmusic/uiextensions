//
//  UILabel+Extensions.h
//
//  Created by Murat on 15.08.13.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extensions)
- (void)setTextToAutoTrancate:(NSString *)text; // to avoid '...' if the end of last line is visible
@end

@implementation UILabel (Extensions)

- (void)setTextToAutoTrancate:(NSString *)text
{
    NSCharacterSet *lineSeparators = [NSCharacterSet newlineCharacterSet];
    NSArray *lines = [text componentsSeparatedByCharactersInSet:lineSeparators];

    const CGFloat ONE_LINE_HEIGHT = [@"A" sizeWithFont: self.font forWidth:1024.0 lineBreakMode: NSLineBreakByWordWrapping].height;
    CGFloat maxHeight = ONE_LINE_HEIGHT * self.numberOfLines;
    
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:self.frame];
    tempLabel.font = self.font;
    tempLabel.numberOfLines = self.numberOfLines;
    tempLabel.lineBreakMode = self.lineBreakMode;
    
    NSMutableString *sumStr = [[NSMutableString alloc] initWithString:@""];
    for (NSString *line in lines)
    {
        [sumStr appendString:line];
        [sumStr appendString:@"\n"];
        tempLabel.text = (NSString *)sumStr;
        CGSize lineSize = [tempLabel sizeThatFits:self.frame.size];
        if (lineSize.height >= maxHeight)
        {
            self.text = (NSString *)sumStr;
            return;
        }
    }
    
    self.text = text; // default
}

@end