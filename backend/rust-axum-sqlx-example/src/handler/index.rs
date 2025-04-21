use utoipa;

#[utoipa::path(
    get,
    path = "/",
    responses(
        (status = 200, description = "Hello World!")
    )
)]
pub async fn index() -> &'static str {
    "Hello, World!"
}
