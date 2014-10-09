package com.game.auction.view
{
    import com.f1.ui.*;
    import com.game.auction.control.*;

    public class StallsList extends Component
    {
        private var _search:AuctionSearchContainer;
        private var _type:String;
        private var _openTab:String;

        public function StallsList(param1:String = null)
        {
            this._type = param1;
            this._search = new AuctionSearchContainer();
            this._search.x = 2;
            this._search.visible = false;
            addChild(this._search);
            this._search.type = this._type;
            if (param1 == null)
            {
                AuctionControl.getInstance().searchContainer = this._search;
            }
            if (this._openTab != "")
            {
                this.openContainer(this._openTab);
            }
            return;
        }// end function

        public function openContainer(param1:String) : void
        {
            this._openTab = param1;
            if (!this._search)
            {
                this._search.visible = true;
                this._openTab = "";
            }
            return;
        }// end function

        public function openSearch() : void
        {
            this._search.visible = true;
            this._search.reset();
            return;
        }// end function

        public function openBooth() : void
        {
            this._search.visible = false;
            return;
        }// end function

    }
}
