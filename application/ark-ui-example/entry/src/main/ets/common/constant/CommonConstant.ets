
/**
 * Common constants for all features.
 */
export default class CommonConstant {

  /**
   * The sql of creating sports table.
   */
  static readonly CREATE_SPORTS_TABLE_SQL: string =
    'CREATE TABLE IF NOT EXISTS SPORTS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT ' +
      'NOT NULL, TYPE TEXT NOT NULL)';

  /**
   * The sql of creating plans table.
   */
  static readonly CREATE_PLANS_TABLE_SQL: string =
    'CREATE TABLE IF NOT EXISTS PLANS (ID INTEGER PRIMARY KEY AUTOINCREMENT, SPORT_ID INTEGER ' +
      'NOT NULL, DURATION INTEGER NOT NULL, STATUS TEXT NOT NULL)';

  /**
   * The sql of querying all durations.
   */
  static readonly QUERY_ALL_DURATIONS_SQL: string =
    'SELECT DISTINCT DURATION FROM PLANS';

  /**
   * The sql of query all plans.
   */
  static readonly QUERY_ALL_PLANS_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s ' +
      'JOIN PLANS AS p WHERE s.ID = P.SPORT_ID';

  /**
   * The sql of querying plans by duration.
   */
  static readonly QUERY_PLANS_BY_DURATION_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s' +
      ' JOIN PLANS AS p WHERE s.ID = P.SPORT_ID AND p.DURATION = ';

  /**
   * The sql of querying plans by status.
   */
  static readonly QUERY_PLANS_BY_STATUS_SQL: string =
    'SELECT p.id AS ID,s.NAME AS NAME,s.type AS TYPE,p.DURATION AS DURATION,p.STATUS AS STATUS FROM SPORTS AS s' +
      ' JOIN PLANS AS p WHERE s.ID = P.SPORT_ID AND p.STATUS = "';
}