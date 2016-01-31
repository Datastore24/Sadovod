//
//  ViewCustomer.m
//  Sadovod
//
//  Created by Viktor on 23.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "ViewCustomer.h"
#import "UIColor+HexColor.h"
#import "TextViewHeight.h"

@implementation ViewCustomer
{
    TextViewHeight * adressChange;
    TextViewHeight * commentChange;
    CGFloat * heightViewComment;
}

- (id)initWithPhone: (NSString *) phone
            andName: (NSString *) name
         andAddress: (NSString*) address
         andComment: (NSString *) comment
             andSum: (NSString *) sum
        andMainView: (UIView*) view


{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
        
        [self addSubview:[self addLabelPhone]];
        [self addSubview:[self addLabelName]];
        [self addSubview:[self addLabelAddress]];
        [self addSubview:[self addAddressСhangeWithView:view andText:address]];
        [self addSubview:[self addCommentViewWithView:view andHeight:200 andText:comment]];
        [self addSubview:[self addLabelSum]];
        [self addSubview:[self addLabelPhoneChangeWithText:phone]];
        [self addSubview:[self addLabelNameChangeWithText:name]];
        [self addSubview:[self addLabelSumChangeWithText:sum]];
        [self addSubview:[self addButtonConfirmWithView:view]];
        [self addSubview:[self addButtonCallWithView:view]];
        
        
    }
    return self;
}

//Телефон не изменяеммый------------------------------------------------------------
- (UILabel*) addLabelPhone
{
    UILabel * labelPhone = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 80, 20)];
    labelPhone.text = @"Телефон:";
    labelPhone.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelPhone.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    return labelPhone;
}

- (UILabel*) addLabelPhoneChangeWithText: (NSString*) text
{
    UILabel * labelPhoneChange = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 250, 20)];
    labelPhoneChange.text = text;
    labelPhoneChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
    labelPhoneChange.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    return labelPhoneChange;
}

- (UILabel*) addLabelName
{
    UILabel * labelName= [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 35, 20)];
    labelName.text = @"Имя:";
    labelName.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelName.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    return labelName;
}

- (UILabel*) addLabelNameChangeWithText: (NSString*) text
{
    UILabel * labelNameChange= [[UILabel alloc] initWithFrame:CGRectMake(45, 30, 120, 20)];
    labelNameChange.text = text;
    labelNameChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
    labelNameChange.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    return labelNameChange;
}

- (UILabel*) addLabelAddress
{
    UILabel * labelAddress= [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 45, 20)];
    labelAddress.text = @"Адрес:";
    labelAddress.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelAddress.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    return labelAddress;
}

- (TextViewHeight *) addAddressСhangeWithView: (UIView *) viewAdress andText: (NSString*) string
{
    adressChange = [[TextViewHeight alloc] initWithFrame:CGRectMake(10, 70, viewAdress.frame.size.width, 120) andText:string];
    adressChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
    adressChange.editable = NO;
    return adressChange;
}

- (UIView*) addCommentViewWithView: (UIView*) view andHeight: (CGFloat) heightViewComment andText: (NSString*) text
{
    //Текст комментариев--------------------------
    commentChange = [[TextViewHeight alloc] initWithFrame:CGRectMake(20, 30, view.frame.size.width, 120) andText:text];
    commentChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
    commentChange.editable = NO;
    
    UIView * commentView = [[UIView alloc] initWithFrame:CGRectMake(- 10, 70 + adressChange.frame.size.height, view.frame.size.width + 20, commentChange.frame.size.height + 50)];
    
    commentView.layer.borderColor = [UIColor colorWithHexString:@"a9a9a9"].CGColor;
    commentView.layer.borderWidth = 0.7f;
    //Заголовок------------------------------------
    UILabel * labelComment= [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, 20)];
    labelComment.text = @"Комментарий:";
    labelComment.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelComment.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    [commentView addSubview:labelComment];
    [commentView addSubview:commentChange];
    
    return commentView;
}

- (UILabel*) addLabelSum
{
    UILabel * labelSum= [[UILabel alloc] initWithFrame:CGRectMake(10, 70 + adressChange.frame.size.height + commentChange.frame.size.height + 50, 95, 20)];
    labelSum.text = @"Сумма заказа:";
    labelSum.textColor = [UIColor colorWithHexString:@"3038a0"];
    labelSum.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
    
    return labelSum;
}

- (UILabel*) addLabelSumChangeWithText: (NSString*) text
{
    UILabel * labelSumChange= [[UILabel alloc] initWithFrame:CGRectMake(110, 120 + adressChange.frame.size.height + commentChange.frame.size.height, 95, 20)];
    labelSumChange.text = text;
    labelSumChange.textColor = [UIColor colorWithHexString:@"a9a9a9"];
    labelSumChange.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    
    return labelSumChange;
}

- (UIButton*) addButtonConfirmWithView: (UIView*) view
{
    UIButton * buttonConfirm = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonConfirm.frame = CGRectMake(0, 150 + adressChange.frame.size.height + commentChange.frame.size.height, view.frame.size.width, 30);
    buttonConfirm.backgroundColor = [UIColor colorWithHexString:@"3038a0"];
    buttonConfirm.tag = 1068;
    [buttonConfirm setTitle:@"OK" forState:UIControlStateNormal];
    [buttonConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    return buttonConfirm;
}

- (UIButton*) addButtonCallWithView: (UIView*) view
{
    UIButton * buttonCall = [UIButton buttonWithType:UIButtonTypeSystem];
    buttonCall.frame = CGRectMake(view.frame.size.width - 90, 10, 80, 20);
    buttonCall.backgroundColor = nil;
    buttonCall.tag = 1070;
    [buttonCall setTitle:@"Позвонить" forState:UIControlStateNormal];
    [buttonCall setTitleColor:[UIColor colorWithHexString:@"3038a0"] forState:UIControlStateNormal];
    buttonCall.titleLabel.font = [UIFont systemFontOfSize:13];
    
    return buttonCall;
}


@end
