using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MahApps.Metro.IconPacks;

namespace WpfApp.Models
{
    public class MenuItemModel
    {
        public PackIconFontAwesomeKind Icon { get; set; }
        public string Header { get; set; }

        public List<SubItemModel> SubMenus { get; set; } = new List<SubItemModel>();
    }

    public class SubItemModel
    {
        public string Name { get; set; }
        public string TargetView { get; set; }
    }
}
