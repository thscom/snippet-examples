import { connection } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { promptAction } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG: string = 'ConnectionUtil';
const DOMAIN = 0x0000

export class ConnectionUtil {
  netConnection = connection.createNetConnection();

  /**
   *The method of checking whether the monitoring network is connected..
   */
  async isNetworkConnected(): Promise<boolean> {
    let result: boolean = false;
    await connection.getDefaultNet().then(async (data: connection.NetHandle) => {
      if (data.netId === 0) {
        hilog.info(DOMAIN, TAG, 'network error');
        return;
      }
      await connection.getNetCapabilities(data).then(
        (data: connection.NetCapabilities) => {
          let bearerTypes: Set<number> = new Set(data.bearerTypes);
          let bearerTypesNum = Array.from(bearerTypes.values());
          for (let item of bearerTypesNum) {
            if (item === 0) {
              result = true;
              hilog.info(DOMAIN, TAG, 'BEARER_CELLULAR');
            } else if (item === 1) {
              result = true;
              hilog.info(DOMAIN, TAG, 'BEARER_WIFI');
            } else if (item === 3) {
              result = true;
              hilog.info(DOMAIN, TAG, 'BEARER_ETHERNET');
            } else {
              return;
            }
          }
        })
    })
    return result;
  }

  /**
   *The method of opening register.
   */
  openRegister() {
    this.netConnection.register((error: BusinessError) => {
      hilog.info(DOMAIN, TAG, JSON.stringify(error));
    });
  }

  /**
   *The method of listening to the network status.
   */
  registerNetworkAvailableStatus() {
    this.netConnection.on('netAvailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Available'),
        duration: 2000
      });
    });

    this.netConnection.on('netUnavailable', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Unavailable'),
        duration: 2000
      });
    });

    this.netConnection.on('netLost', () => {
      promptAction.showToast({
        message: $r('app.string.Network_Lost'),
        duration: 2000
      });
    });
  }

  /**
   *The method of closing register.
   */
  closeRegister() {
    this.netConnection.unregister((error: BusinessError) => {
      hilog.info(DOMAIN, TAG, JSON.stringify(error));
    });
  }
}

export default new ConnectionUtil();