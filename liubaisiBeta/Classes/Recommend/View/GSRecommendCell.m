//
//  GSRecommendCell.m
//  LiuBaiSi
//
//  Created by 刘高升 on 17/2/27.
//  Copyright © 2017年 刘高升. All rights reserved.
//

#import "GSRecommendCell.h"
#import "GSRecomendModel.h"
@interface GSRecommendCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *detailLable;

@property (weak, nonatomic) IBOutlet UIButton *subscribeButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;



@end
@implementation GSRecommendCell
+ (GSRecommendCell *)initRecommendCellWithTableView:(UITableView *)tableview indexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"recommend";
    GSRecommendCell *cell = [tableview dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"GSRecommendCell" owner:nil options:nil].lastObject;
    }
    
    return cell;

}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.iconImageView sizeToFit];
    self.iconImageView.layer.cornerRadius = self.widthConstraint.constant / 2;
    self.iconImageView.clipsToBounds = YES;
    // Initialization code
}

//订阅按钮
- (IBAction)subscribeClick:(UIButton *)sender {
}

- (void)setModel:(GSRecomendModel *)model{
    _model = model;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.image_list]];
    self.nameLable.text = model.theme_name;
    self.detailLable.text = [NSString stringWithFormat:@"订阅人数:%ld人",model.sub_number];


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
