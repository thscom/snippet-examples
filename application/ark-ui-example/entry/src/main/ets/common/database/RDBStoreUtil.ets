import {relationalStore } from '@kit.ArkData'
import {hilog} from '@kit.PerformanceAnalysisKit'
import {BusinessError} from '@kit.BasicServicesKit'
import {GoalItem} from '../../model/GoalItem'
import  CC from '../constant/CommonConstant'
import { Context } from '@kit.AbilityKit'


const TAG: string = "RDBStoreUtil"
const DOMAIN = 0x0000

export class RDBStoreUtil {
  objRDB?: relationalStore.RdbStore

  createObjectiveRDB(context: Context) {
    const STORE_CONFIG: relationalStore.StoreConfig = {
      name: 'ArkUIExample.db',
      securityLevel: relationalStore.SecurityLevel.S1
    }

    relationalStore.getRdbStore(context, STORE_CONFIG,
      (err: BusinessError, rdbStore: relationalStore.RdbStore) => {
      this.objRDB = rdbStore
        if (err) {
          hilog.error(DOMAIN, TAG, `Get RdbStore failed, code = ${err.code}, message = ${err.message}`)
          return
        }
        hilog.info(DOMAIN, TAG, "Get RdbStore successfully")
    })
  }

  /**
   *The method of creating a sport table.
   */
  createSportTable() {
    this.objRDB?.execute(CC.CREATE_SPORTS_TABLE_SQL)
      .then(() => {
        hilog.info(0x0000, TAG, `execute create sport table sql success`);
      })
      .catch((err: BusinessError) => {
        hilog.error(0x0000, TAG, `execute sql failed, code is ${err.code},message is ${err.message}`);
      });
  }

  /**
   *The method of creating a plan table.
   */
  createPlanTable() {
    this.objRDB?.execute(CC.CREATE_PLANS_TABLE_SQL)
      .then(() => {
        hilog.info(0x0000, TAG, `execute create plas table sql success`);
      })
      .catch((err: BusinessError) => {
        hilog.error(0x0000, TAG, `execute sql failed, code is ${err.code},message is ${err.message}`);
      });
  }

  /**
   *The method of Initializing sport table.
   */
  initSportTable() {
    const sportDataOne: relationalStore.ValuesBucket = {
      'ID': 0,
      'NAME': '晨跑',
      'TYPE': '有氧运动'
    };
    const sportDataTWO: relationalStore.ValuesBucket = {
      'ID': 1,
      'NAME': '瑜伽',
      'TYPE': '柔韧运动'
    };
    const sportDataThree: relationalStore.ValuesBucket = {
      'ID': 2,
      'NAME': '游泳',
      'TYPE': '有氧运动'
    };
    let valueBuckets = new Array(sportDataOne, sportDataTWO, sportDataThree);
    this.objRDB?.batchInsert('SPORTS', valueBuckets).then((insertNum: number) => {
      hilog.info(0x0000, TAG, `batchInsert is successful, the number of values that were inserted = ${insertNum}`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `batchInsert is failed, code is ${err.code},message is ${err.message}`);
    })
  }

  /**
   *The method of querying all durations in all plans.
   */
  async queryAllPlansDuration(): Promise<number[]> {
    let plansSet: Array<number> = [];
    await this.objRDB?.querySql(CC.QUERY_ALL_DURATIONS_SQL).then((resultSet: relationalStore.ResultSet) => {
      while (resultSet.goToNextRow()) {
        let duration: number = resultSet.getValue(resultSet.getColumnIndex('DURATION')) as number;
        plansSet.push(duration);
      }
      resultSet.close();
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Query failed, code is ${err.code},message is ${err.message}`);
    })
    return plansSet;
  }

  /**
   *The method of querying all plans.
   */
  async queryAllPlans(): Promise<GoalItem[]> {
    let plansSet: Array<GoalItem> = [];
    await this.objRDB?.querySql(CC.QUERY_ALL_PLANS_SQL)
      .then((resultSet: relationalStore.ResultSet) => {
        while (resultSet.goToNextRow()) {
          const id = resultSet.getValue(resultSet.getColumnIndex('ID')) as number;
          const name = resultSet.getValue(resultSet.getColumnIndex('NAME')) as string;
          const type = resultSet.getValue(resultSet.getColumnIndex('TYPE')) as string;
          const duration = resultSet.getValue(resultSet.getColumnIndex('DURATION')) as number;
          const status = resultSet.getValue(resultSet.getColumnIndex('STATUS')) as string;
          plansSet.push(new GoalItem(id, name, type, duration, status));
        }
        resultSet.close();
      }).catch((err: BusinessError) => {
        hilog.error(0x0000, TAG, `Query failed, code is ${err.code},message is ${err.message}`);
      })
    return plansSet;
  }

  /**
   *The method of inserting a plan information.
   */
  async insertPlan(sportID: number, duration: number, status: boolean) {
    const sportData: relationalStore.ValuesBucket = {
      'SPORT_ID': sportID,
      'DURATION': duration,
      'STATUS': status ? '已完成' : '未完成'
    };
    await this.objRDB?.insert('PLANS', sportData,
      relationalStore.ConflictResolution.ON_CONFLICT_REPLACE).then((rowId: number) => {
      hilog.info(0x0000, TAG, `Insert is successful, rowId = ${rowId}`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Insert is failed, code is ${err.code},message is ${err.message}`);
    })
  }

  /**
   *The method of updating a plan information.
   */
  async updatePlan(planID: number, duration: number, status: boolean) {
    const planData: relationalStore.ValuesBucket = {
      'DURATION': duration,
      'STATUS': status ? '已完成' : '未完成'
    };
    let predicates = new relationalStore.RdbPredicates('PLANS');
    predicates.equalTo('ID', planID);
    await this.objRDB?.update(planData, predicates,
      relationalStore.ConflictResolution.ON_CONFLICT_REPLACE).then(async (rows: Number) => {
      hilog.info(0x0000, TAG, `Updated row count: ${rows}`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Updated failed, code is ${err.code},message is ${err.message}`);
    })
  }

  /**
   *The method of deleting a plan information.
   */
  async deletePlan(planID: number) {
    let predicates = new relationalStore.RdbPredicates('PLANS');
    predicates.equalTo('ID', planID);
    await this.objRDB?.delete(predicates).then((rows: Number) => {
      hilog.info(0x0000, TAG, `Delete rows: ${rows}`);
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Delete failed, code is ${err.code},message is ${err.message}`);
    })
  }

  /**
   *The method of filtering all plans based on different criteria.
   */
  async conditionalPlansQuery(duration: number | undefined, status: boolean | undefined): Promise<GoalItem[]> {
    let plansSet: Array<GoalItem> = [];
    let querySql: string = '';
    if (status === undefined) {
      if (duration === undefined) {
        querySql = CC.QUERY_ALL_PLANS_SQL;
      } else {
        querySql = CC.QUERY_PLANS_BY_DURATION_SQL + duration;
      }
    } else {
      let statusCondition: string = status ? '已完成' : '未完成';
      if (duration === undefined) {
        querySql = CC.QUERY_PLANS_BY_STATUS_SQL + statusCondition + '"';
      } else {
        querySql = CC.QUERY_PLANS_BY_STATUS_SQL + statusCondition + '" and p.DURATION = ' + duration;
      }
    }
    await this.objRDB?.querySql(querySql).then((resultSet: relationalStore.ResultSet) => {
      while (resultSet.goToNextRow()) {
        const id = resultSet.getValue(resultSet.getColumnIndex('ID')) as number;
        const name = resultSet.getValue(resultSet.getColumnIndex('NAME')) as string;
        const type = resultSet.getValue(resultSet.getColumnIndex('TYPE')) as string;
        const duration = resultSet.getValue(resultSet.getColumnIndex('DURATION')) as number;
        const status = resultSet.getValue(resultSet.getColumnIndex('STATUS')) as string;
        plansSet.push(new GoalItem(id, name, type, duration, status));
      }
      resultSet.close();
    }).catch((err: BusinessError) => {
      hilog.error(0x0000, TAG, `Query failed, code is ${err.code},message is ${err.message}`);
    })
    return plansSet;
  }
}

export default new RDBStoreUtil()