package com.game.newactivity.mergeService.view.mergeView
{
    import com.f1.ui.*;
    import com.f1.ui.list.*;
    import com.f1.utils.*;
    import com.model.vo.*;
    import flash.display.*;

    public class GiftPanel extends Component
    {
        private var itemList:MovieClip;
        private var _list:List;

        public function GiftPanel(param1 = null, param2:String = null)
        {
            super(param1, param2);
            this.itemList = getDisplayChildByName("itemList");
            this._list = new List(523, 238, null, "scrollBar2");
            this._list.move(this.itemList.x, this.itemList.y);
            this._list.cellRenderer = FiveItem;
            addChild(this._list);
            return;
        }// end function

        public function setInfo(param1:NewActivityInfo) : void
        {
            FiveItem.DAY_INDEX = (ToolKit.getServerTime() / 1000 - param1.beginTime) / (24 * 60 * 60);
            var _loc_2:* = FiveItem.DAY_INDEX;
            this._list.objs = param1.activityItemLists;
            return;
        }// end function

    }
}
