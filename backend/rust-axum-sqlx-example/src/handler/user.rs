use axum::Json;
use axum::http::StatusCode;

use crate::database::get_pool;
use crate::model::user::User;

#[utoipa::path(
    get,
    path = "/users",
    responses(
        (status = 200, description = "Get all users", body = Vec<User>),
        (status = 404, description = "No users found"),
    )
)]
pub async fn get_all_users() -> (StatusCode, Json<Vec<User>>) {
    let pool = get_pool();
    let res = sqlx::query_as("SELECT * FROM users").fetch_all(pool).await;
    match res {
        Ok(us) => (StatusCode::OK, Json(us)),
        Err(e) => {
            eprintln!("Error fetching users: {:?}", e);
            (StatusCode::NOT_FOUND, Json(vec![]))
        }
    }
}

#[utoipa::path(
    post,
    path = "/users",
    responses(
        (status = 201, description = "User created"),
        (status = 500, description = "Internal server error"),
    )
)]
pub async fn create_user() -> StatusCode {
    let pool = get_pool();

    let res = sqlx::query("INSERT INTO users (username, password) VALUES (?, ?)")
        .bind("test")
        .bind("test")
        .execute(pool)
        .await;
    match res {
        Ok(_) => StatusCode::CREATED,
        Err(e) => {
            eprintln!("Error fetching users: {:?}", e);
            StatusCode::INTERNAL_SERVER_ERROR
        }
    }
}
