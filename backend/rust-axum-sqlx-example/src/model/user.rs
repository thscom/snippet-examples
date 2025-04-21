use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use sqlx::FromRow;
use utoipa::ToSchema;

#[derive(Debug, FromRow, Serialize, Deserialize, ToSchema)]
pub struct User {
    pub id: i32,
    #[schema(example = "test")]
    pub username: String,
    #[schema(example = "test")]
    pub password: String,
    pub created_at: DateTime<Utc>,
    pub updated_at: DateTime<Utc>,
    pub deleted_at: Option<DateTime<Utc>>,
}
