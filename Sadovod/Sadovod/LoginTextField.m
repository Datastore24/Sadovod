//
//  LoginTextField.m
//  Sadovod
//
//  Created by Viktor on 18.01.16.
//  Copyright © 2016 Viktor. All rights reserved.
//

#import "LoginTextField.h"

@implementation LoginTextField

- (id)initWithFrame:(CGRect)frame
                  placeholder: (NSString *) placeholder
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.layer.borderColor = [UIColor blackColor].CGColor;
        self.layer.borderWidth = 1.f;
        self.layer.cornerRadius = 5.f;
        self.returnKeyType = UIReturnKeyDone;
        self.borderStyle = UITextBorderStyleRoundedRect; // граница рамки ввода текста
        self.textColor = [UIColor blackColor];
        self.font = [UIFont systemFontOfSize:17.0];
        self.backgroundColor = [UIColor clearColor];
        self.autocorrectionType = UITextAutocorrectionTypeNo; // подсказки в ходе набора текста пользователем
        self.keyboardType = UIKeyboardTypeDefault; //задаем раскладку клавиатуры
        self.clearButtonMode = UITextFieldViewModeWhileEditing; //определяет наличие с правой стороны кнопки очистки содержимого текстового поля
        self.placeholder = placeholder; //Плейсхолдер
        self.enablesReturnKeyAutomatically = YES; // клавиша "ввод" не активна, пока пользователь не введет значение
    }
    return self;
}

@end
