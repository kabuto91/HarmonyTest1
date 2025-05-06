import { hilog } from "@kit.PerformanceAnalysisKit"

interface levelInterface {
  info: hilog.LogLevel,
  warn: hilog.LogLevel,
  debug: hilog.LogLevel,
  error: hilog.LogLevel,
}

export class LoggingUtil {
  private isLoggable: boolean = false
  private levelMap: levelInterface = {
    info: hilog.LogLevel.INFO,
    warn: hilog.LogLevel.WARN,
    debug: hilog.LogLevel.DEBUG,
    error: hilog.LogLevel.ERROR
  }

  private validateIsLoggable(domain: number, tag: string, level: string) {
    this.isLoggable = hilog.isLoggable(domain, tag, Reflect.get(this.levelMap, level))
  }

  info(domain: number = 0x0000, tag: string, format: string = '%{public}s', ...args: Array<string|number|boolean>) {
    if (!this.isLoggable) {
      this.validateIsLoggable(domain, tag, 'info')
    }
    hilog.info(domain, tag, format, ...args)
  }

  warn(domain: number = 0x0000, tag: string, format: string = '%{public}s', ...args: Array<string|number|boolean>) {
    if (!this.isLoggable) {
      this.validateIsLoggable(domain, tag, 'warn')
    }
    hilog.warn(domain, tag, format, ...args)
  }

  error(domain: number = 0x0000, tag: string, format: string = '%{public}s', ...args: Array<string|number|boolean>) {
    if (!this.isLoggable) {
      this.validateIsLoggable(domain, tag, 'error')
    }
    hilog.error(domain, tag, format, ...args)
  }

  debug(domain: number = 0x0000, tag: string, format: string = '%{public}s', ...args: Array<string|number|boolean>) {
    if (!this.isLoggable) {
      this.validateIsLoggable(domain, tag, 'debug')
    }
    hilog.debug(domain, tag, format, ...args)
  }

}

export default new LoggingUtil();