
@Extend(TextInput)
function inputStyle() {
  .placeholderColor('#33182431')
  .height('45vp')
  .fontSize('18fp')
  .backgroundColor('#F1F3F5')
  .width('100%')
  .margin({ top: 12 })
}

@Extend(Line)
function lineStyle() {
  .width('100%')
  .height('1vp')
  .backgroundColor('#33182431')
}

@Entry
@Component
struct LoginPage {

  packStack: NavPathStack = new NavPathStack()
  build() {
    Navigation(this.packStack) {
      Column() {
        Column() {
          Image($r('app.media.startIcon'))
            .width('78vp')
            .height('78vp')
            .margin({ bottom: '24vp' })
          TextInput({ placeholder: $r('app.string.Login_User_PlaceHolder') })
            .maxLength(11)
            .inputStyle()
          Line()
            .lineStyle()
          TextInput({ placeholder: $r('app.string.Login_Password_PlaceHolder') })
            .type(InputType.Password)
            .inputStyle()
          Line()
            .lineStyle()
        }
      }
      .width('100%')
      .height('100%')
      .padding({ left: '24vp', right: '24vp' })
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .hideTitleBar(true)
    .hideToolBar(true)
    .backgroundColor('#F1F3F5')
  }
}