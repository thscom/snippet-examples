use crate::handler;
use utoipa::OpenApi;
use utoipa_axum::{router::OpenApiRouter, routes};

#[derive(OpenApi)]
#[openapi()]
pub struct ApiDoc;

pub fn get_openapi() -> OpenApiRouter {
    OpenApiRouter::new()
        .routes(routes!(handler::index::index))
        .routes(routes![
            handler::user::get_all_users,
            handler::user::create_user
        ])
}
