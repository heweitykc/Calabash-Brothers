package com.game.stalls.view
{
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.game.stalls.bean.*;
    import com.game.stalls.control.*;

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
            this._list = new List(630, 416);
            this._list.cellRenderer = LogItem;
            this._list.intervalY = 4;
            this._list.move(0, 15);
            addChild(this._list);
            if (StallsControl.getInstance().logInfo)
            {
                this.info = StallsControl.getInstance().logInfo;
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
