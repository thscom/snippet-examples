using Microsoft.OpenApi.Models;
using WebApi.Constants;

namespace WebApi.Commons
{
    public static class SwaggerExtension
    {
        /// <summary>
        /// 注册Swagger
        /// </summary>
        /// <param name="services"></param>
        public static void AddSwaggerExt(this IServiceCollection services)
        {
            services.AddSwaggerGen(option =>
            {
                #region 通过反射获取注释中的API描述
                string basePath = Path.GetDirectoryName(typeof(Program).Assembly.Location) ?? "";
                string xmlPath = Path.Combine(basePath, "WebApi.xml");
                option.IncludeXmlComments(xmlPath, true);
                #endregion
                //option.SwaggerDoc("v1", new Microsoft.OpenApi.Models.OpenApiInfo { Title = "Net 8 WebAPI Example", Version = "v1"});
                #region 版本控制
                foreach (var v in typeof(VersionInfo).GetEnumNames())
                {
                    option.SwaggerDoc(v, new Microsoft.OpenApi.Models.OpenApiInfo()
                    {
                        Title = $"Net 8 WebAPI Example {v}",
                        Version = v,
                        Description = $"{v} WebAPI",
                    });
                }
                #endregion
                #region 权限管理
                option.AddSecurityDefinition("Bearer", new Microsoft.OpenApi.Models.OpenApiSecurityScheme
                {
                    Name = "Authorization",
                    Description = "Bearer Token",
                    In = Microsoft.OpenApi.Models.ParameterLocation.Header,
                    Type = Microsoft.OpenApi.Models.SecuritySchemeType.ApiKey,
                    BearerFormat = "JWT",
                    Scheme = "Bearer"
                });
                option.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement
                {
                     {
                        new OpenApiSecurityScheme {
                            Reference = new OpenApiReference
                            {
                                Id = "Bearer",
                                Type = ReferenceType.SecurityScheme
                            }
                        },
                        new string[] { }
                    }
                });
                #endregion
            });
        }

        public static void UseSwaggerExt(this WebApplication app)
        {
            app.UseSwagger();
            app.UseSwaggerUI(option =>
            {
                foreach (var v in typeof(VersionInfo).GetEnumNames())
                {
                    option.SwaggerEndpoint($"/swagger/{v}/swagger.json", $"{v}");
                }
            });
        }
    }
}
