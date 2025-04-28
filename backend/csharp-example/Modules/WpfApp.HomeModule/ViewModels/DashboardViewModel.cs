using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using WpfApp.HomeModule.Models;

namespace WpfApp.HomeModule.ViewModels
{
    public class DashboardViewModel
    {
        public List<TabItem> TabItems { get; set; }

        public DashboardViewModel() { 
            TabItems = [
                new TabItem{ Title = "Tab A" },
                new TabItem{ Title = "Tab B" }
            ];
        }
    }
}
