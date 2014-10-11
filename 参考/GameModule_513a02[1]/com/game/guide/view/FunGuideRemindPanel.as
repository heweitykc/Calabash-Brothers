package com.game.guide.view
{
    import com.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.ui.list.*;
    import com.game.guide.model.*;
    import flash.events.*;
    import flash.text.*;

    public class FunGuideRemindPanel extends BaseBox
    {
        private var _itemArr:Array;
        private var _closeBtn:BaseButton;
        private var _illustrateTxt:TextField;
        private var _list:List;
        private var _box:HBox;
        private var _info:FunGuideCfg;
        private var _layoutInfo:LayoutInfo;

        public function FunGuideRemindPanel()
        {
            _peaceBox = ["*"];
            loadDisplay("res/funguideremind.swf");
            return;
        }// end function

        public function get info() : FunGuideCfg
        {
            return this._info;
        }// end function

        public function set info(param1:FunGuideCfg) : void
        {
            this._info = param1;
            if (UILoaded)
            {
                this.updateInfo();
                this._illustrateTxt.htmlText = param1.illustrate;
            }
            return;
        }// end function

        private function updateInfo() : void
        {
            var _loc_1:* = this._info.funArr.slice(0, 3);
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                this._itemArr[_loc_2].info = _loc_1[_loc_2];
                this._itemArr[_loc_2].visible = true;
                _loc_2++;
            }
            while (_loc_2 < 3)
            {
                
                this._itemArr[_loc_2].visible = false;
                _loc_2++;
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("funremindpanel");
            this.initUI();
            this.addlisteners();
            this.updateInfo();
            this._illustrateTxt.htmlText = this._info.illustrate;
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            var _loc_2:* = null;
            this._illustrateTxt = getDisplayChildByName("txt_illustrate");
            this._itemArr = [];
            var _loc_1:* = 1;
            while (_loc_1 < 4)
            {
                
                _loc_2 = new FunGuideRemindItem(getDisplayChildByName("item_" + _loc_1));
                this._itemArr.push(_loc_2);
                _loc_1++;
            }
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn1"));
            return;
        }// end function

        public function addlisteners() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            return;
        }// end function

        protected function openPanel() : void
        {
            if (!this._layoutInfo)
            {
                this._layoutInfo = new LayoutInfo(Layout.BOTTOM_RIGHT, 0, 105);
            }
            Global.popManager.addUI(this, this._layoutInfo);
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.openPanel();
            return;
        }// end function

        public function __close(event:MouseEvent) : void
        {
            Global.popManager.removeUI(this);
            return;
        }// end function

    }
}
