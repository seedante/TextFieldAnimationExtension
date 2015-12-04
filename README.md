# TextFieldAnimationExtension


Last week, @Joel Besada show an effect for [code edit](https://twitter.com/JoelBesada/status/670343885655293952). It's cool and useless.

![](https://cloud.githubusercontent.com/assets/688415/11440971/aadfae8e-9507-11e5-8aa0-0ecc87ca84b6.gif)

What about this effect on iOS input? I think shake effect is not good for input, if you rock users, they will delete your app and give one star on app store.  

I explore some effects. Here is:

Default effect:

![Delete Animation](https://github.com/seedante/TextFieldAnimationExtension/blob/master/Screenshot/DeleteAnimation.gif)

Color Effect:

![Color Animation](https://github.com/seedante/TextFieldAnimationExtension/blob/master/Screenshot/ColorDeleteAnimation.gif)

I don't think add effect on input is a good idea, but I still make a sample. You can custom input effect and in default it's disabled.

![Input Animtion](https://github.com/seedante/TextFieldAnimationExtension/blob/master/Screenshot/InputAnimation.gif)

A ha, Rock you. Don't use this in your app.

![Rock You](https://github.com/seedante/TextFieldAnimationExtension/blob/master/Screenshot/RockYou.gif)


## Installation and Usage

It's an extension! Drag **SDETextFieldExtension.swift** into your project. 

Enable effect:

	textField.addSDEEffect()
	
Disable effect:

	textField.removeSDEEffect()

Enable random color animation:

	textField.colorDeleteAnimationEnabled = true

Input effect is disabled in default. You can enable and custom it:

	textField.inputAnimationEnabled = true
	textField.inputAnimationText = "❤️"//Accept the first letter

In theory, UITextView can do same thing. I will implement it if I am not busy and in a good mood.
