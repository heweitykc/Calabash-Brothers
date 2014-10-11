package com.game.auction.view
{
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.game.auction.control.*;
    import com.game.stalls.bean.*;

    public class LogContainer extends Component
    {
        private var _info:StallsLogInfo;
        private var _list:List;

        public function LogContainer(param1 = "logcontainer")
        {
            super(param1);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._list = new List(804, 422);
            this._list.cellRenderer = LogItem;
            this._list.intervalY = 3;
            this._list.move(7, 8);
            addChild(this._list);
            if (AuctionControl.getInstance().logInfo)
            {
                this.info = AuctionControl.getInstance().logInfo;
            }
            return;
        }// end function

        public function get info() : StallsLogInfo
        {
            return this._info;
        }// end function

        public function set info(param1:StallsLogInfo) : void
        {
            this._info = param1;
            var _loc_2:* = [];
            var _loc_3:* = 0;
            while (_loc_3 < this._info.stallsloglist.length)
            {
                
                _loc_2.push(this._info.stallsloglist[_loc_3]);
                _loc_3++;
            }
            this._list.objs = _loc_2;
            return;
        }// end function

    }
}
