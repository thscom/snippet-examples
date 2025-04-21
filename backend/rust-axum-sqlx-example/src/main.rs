mod database;
mod handler;
mod model;
mod router;

use anyhow::Result;
use tokio;
use utoipa::OpenApi;
use utoipa_axum::router::OpenApiRouter;
use utoipa_swagger_ui::SwaggerUi;

#[tokio::main]
async fn main() -> Result<()> {
    dotenvy::dotenv()?;
    tracing_subscriber::fmt::init();

    database::init_db().await?;

    let (router, api) = OpenApiRouter::with_openapi(router::ApiDoc::openapi())
        .nest("/api/v1", router::get_openapi())
        .split_for_parts();

    let router =
        router.merge(SwaggerUi::new("/swagger-ui").url("/api-docs/openapi.json", api.clone()));

    // let app = Router::new()
    //     .route("/", get(handler::index::index))
    //     .route("/users", get(handler::user::get_all_users))
    //     .route("/users", post(handler::user::create_user));

    let listener = tokio::net::TcpListener::bind("0.0.0.0:3000").await.unwrap();
    tracing::debug!("listening on {}", listener.local_addr().unwrap());
    axum::serve(listener, router).await.unwrap();
    Ok(())
}
