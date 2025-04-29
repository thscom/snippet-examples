using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MahApps.Metro.IconPacks;

namespace WalletApp.Models
{
    public class MenuItem
    {
        public string Title { get; set; }
        public PackIconFontAwesomeKind Icon { get; set; }
        public string TargetView { get; set; }
    }
}
