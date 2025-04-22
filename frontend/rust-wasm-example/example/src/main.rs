use actix_files as fs;
use actix_web::{App, HttpServer, middleware};

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .service(fs::Files::new("/", "./public/").index_file("index.html"))
    })
    .bind("0.0.0.0:3000")?
    .run()
    .await
}
