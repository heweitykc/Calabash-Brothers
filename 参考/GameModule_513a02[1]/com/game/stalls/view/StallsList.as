package com.game.stalls.view
{
    import com.f1.ui.*;
    import com.game.stalls.control.*;

    public class StallsList extends Component
    {
        private var _search:StallsSearchContainer;
        private var _booth:BoothContainer;
        private var _type:String;
        private var _openTab:String;

        public function StallsList(param1:String = null)
        {
            this._type = param1;
            this._search = new StallsSearchContainer();
            this._search.x = 2;
            this._search.visible = false;
            addChild(this._search);
            this._booth = new BoothContainer();
            this._booth.visible = false;
            addChild(this._booth);
            this._search.type = this._type;
            this._booth.type = this._type;
            if (param1 == null)
            {
                StallsControl.getInstance().searchContainer = this._search;
                StallsControl.getInstance().boothContainer = this._booth;
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
            if (!this._search || !this._booth)
            {
                this._search.visible = param1 == StallsControl.BOOTH ? (false) : (true);
                this._booth.visible = param1 == StallsControl.LIST ? (false) : (true);
                this._openTab = "";
            }
            return;
        }// end function

        public function openSearch() : void
        {
            this._search.visible = true;
            this._booth.visible = false;
            return;
        }// end function

        public function openBooth() : void
        {
            this._search.visible = false;
            this._booth.visible = true;
            return;
        }// end function

    }
}
