import PreferencesUtil from '../common/database/PreferenceUtil';
import LoggingUtil from '../common/utils/logging';


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

  @State username: string = '';
  @State password: string = '';
  @State isRememberUser: boolean = false

  aboutToAppear() {
    LoggingUtil.info(0x0000, 'test', '%{public}s', 'start')
    const loginUser = PreferencesUtil.getLoginUser()
    LoggingUtil.info(0x0000, 'test', '%{public}s', `user: ${loginUser}`)
    if (loginUser) {
      this.isRememberUser = true
      this.username = loginUser
    }
  }

  build() {
    Navigation(this.packStack) {
      Column() {
        Column() {
          Image($r('app.media.startIcon'))
            .width('78vp')
            .height('78vp')
            .margin({ bottom: '24vp' })
          TextInput({ placeholder: $r('app.string.Login_User_PlaceHolder'), text: this.username })
            .maxLength(11)
            .inputStyle()
            .onChange((value: string) => {
              this.username = value;
            })
          Line()
            .lineStyle()
          TextInput({ placeholder: $r('app.string.Login_Password_PlaceHolder') })
            .type(InputType.Password)
            .inputStyle()
          Line()
            .lineStyle()
          Flex({ alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceBetween }) {
            Row() {
              Checkbox({ name: 'isRememberUser' })
                .select(this.isRememberUser)
                .shape(CheckBoxShape.ROUNDED_SQUARE)
              Text($r('app.string.login_remember_user'))
            }
            Text($r('app.string.forget_password'))
          }
          .width('100%')
          .margin({ top: '12vp' })
          .onClick(() => {
            this.isRememberUser = !this.isRememberUser


          })
          Button($r('app.string.login_button'))
            .type(ButtonType.ROUNDED_RECTANGLE)
            .width('40%')
            .margin({ top: '24vp' })
            .borderRadius(16)
            .onClick(() => {
              LoggingUtil.info(0x0000, 'test', '%{public}s', `isRemember: ${this.isRememberUser}`)
              LoggingUtil.info(0x0000, 'test', '%{public}s', `username: ${this.username}`)
              if (this.isRememberUser && this.username) {
                PreferencesUtil.saveLoginUser(this.username)
              }
            })

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
    .mode(NavigationMode.Stack)
  }
}