package com.game.goldRaffle.view.component
{
    import com.f1.*;
    import com.f1.ui.image.*;
    import com.game.backpack.view.*;
    import com.game.goldRaffle.bean.*;
    import com.game.goldRaffle.control.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;

    public class TreasureBoxItem extends IconItem
    {
        protected var _gridId:int;
        private var _statusImg:Image;

        public function TreasureBoxItem(param1:String = "backpackbox_bg")
        {
            super(param1);
            setWH(46, 46);
            _backImage.x = 1;
            _backImage.y = 1;
            buttonMode = true;
            mouseChildren = false;
            mouseEnabled = true;
            _image.move(3, 3);
            return;
        }// end function

        public function get gridId() : int
        {
            return this._gridId;
        }// end function

        public function setGridinfo(param1:GoldRaffleGridInfo) : void
        {
            _info = PropUtil.createItemByItemInfo(param1.coupon);
            (_info as PropInfo).blongToMine = true;
            this._gridId = param1.grididx;
            this.setInfo(_info);
            return;
        }// end function

        public function setDes() : void
        {
            if (_info)
            {
                if (_info.num > 1)
                {
                    (_info.num - 1);
                }
                else
                {
                    _info = null;
                }
                this.setInfo(_info);
            }
            return;
        }// end function

        override public function setInfo(param1:Object, param2:Boolean = false) : void
        {
            _info = param1 as PropInfo;
            super.setInfo(param1, param2);
            return;
        }// end function

        override protected function doDoubleClick() : void
        {
            if (_info)
            {
                GoldRaffleControl.getInstance().reqGoldRaffleBoxUseItemToServer(this._gridId, 2);
            }
            super.doDoubleClick();
            return;
        }// end function

        private function __click2(event:MouseEvent) : void
        {
            if (_info)
            {
                if (_info.q_ui == 0)
                {
                    ItemPopMenu.instance.show(_info, FrameworkGlobal.stage, 2, 2, ItemPopMenu.TREASURE1, null, this._gridId);
                }
                else
                {
                    ItemPopMenu.instance.show(_info, FrameworkGlobal.stage, 2, 2, ItemPopMenu.TREASURE2, null, this._gridId);
                }
            }
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
