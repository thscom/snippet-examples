using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using WebApi.Entities;
using WebApi.Services;

namespace WebApi.Commons
{
    public static class AuthExtension
    {
        public static void AddAuthExt(this IServiceCollection services, IConfigurationSection jwtSettingSection)
        {
            // Dependencies Injection For Authorization
            services.AddTransient<AuthService>();
            services.AddOptions();
            services.Configure<JwtSetting>(jwtSettingSection);

            // Enable Authorization
            services.AddAuthentication();
            services.AddAuthorization();

            // JWT Authentication
            var jwtSettings = jwtSettingSection.Get<JwtSetting>();

            services.AddAuthentication(t =>
            {
                t.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
                t.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
            }).AddJwtBearer(t =>
            {
                t.TokenValidationParameters = new Microsoft.IdentityModel.Tokens.TokenValidationParameters
                {
                    ValidateIssuer = false,
                    ValidateAudience = false,
                    IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtSettings.SecretKey))
                };
            });
            services.AddAuthorization(t =>
            {
                t.AddPolicy("rolePolicy", p => p.RequireRole("admin"));
            });
        }
    }
}
