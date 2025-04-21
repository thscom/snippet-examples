use once_cell::sync::OnceCell;
use sqlx::{MySqlPool, mysql::MySqlPoolOptions};

pub static DB: OnceCell<MySqlPool> = OnceCell::new();

pub async fn init_db() -> sqlx::Result<MySqlPool> {
    let db_url = std::env::var("DATABASE_URL").expect("DATABASE_URL is not set");
    let pool = MySqlPoolOptions::new()
        .max_connections(5)
        .connect(&db_url)
        .await?;
    let _ = DB.set(pool);
    Ok(DB.get().expect("DB is not initialized").clone())
}

pub fn get_pool() -> &'static MySqlPool {
    DB.get().expect("DB is not initialized")
}
