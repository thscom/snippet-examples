using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfApp.HomeModule.Views;
using Prism.Modularity;

namespace WpfApp.HomeModule
{
    public class ModuleHome : IModule
    {
        public void OnInitialized(IContainerProvider containerProvider)
        {
            //
        }

        public void RegisterTypes(IContainerRegistry containerRegistry)
        {
            containerRegistry.RegisterForNavigation<Views.DashboardPage>();
        }
    }
}
