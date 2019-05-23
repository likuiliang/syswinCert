//
//  TNCBaseItemCell.m
//  AFNetworking
//
//  Created by likuiliang-Answer on 2018/7/11.
//

#import "TNCBaseItemCell.h"
//#import "TSkin.h"

@implementation TNCBaseItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
//        self.sakura.backgroundColor(@"Global.backgroundColor");
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)reloadCellWithModel:(TNCBaseItem *)model
{
    self.model = model;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:18];
//        _titleLabel.sakura.textColor(@"Global.text_main_color");
    }
    return _titleLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [UIView new];
//        _lineView.sakura.backgroundColor(@"Global.separator_color");
    }
    return _lineView;
}

@end
