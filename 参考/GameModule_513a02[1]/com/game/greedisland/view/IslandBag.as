package com.game.greedisland.view
{
    import __AS3__.vec.*;
    import com.f1.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.list.*;
    import com.game.greedisland.model.*;
    import com.model.vo.*;
    import com.util.*;
    import com.view.icon.*;
    import flash.events.*;

    public class IslandBag extends BaseBox
    {
        private var btn_close:BaseButton;
        private var btn1:BaseButton;
        private var btn2:BaseButton;
        private var btn3:BaseButton;
        private var btn4:BaseButton;
        private var _type:int = 1;
        private var btnAry:Array;
        private var awardsHbox:ListHBox;
        private var list:List;
        private var islandData:IslandData;

        public function IslandBag()
        {
            this.btnAry = [];
            this.islandData = IslandData.getInstance();
            loadDisplay("res/islandbag.swf");
            _peaceBox = ["*"];
            return;
        }// end function

        override protected function displayReady() : void
        {
            initBaseBoxUI("islandBag");
            this.initUI();
            this.addEvents();
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.btn_close = new BaseButton(getDisplayChildByName("btn_close"));
            this.btn1 = new BaseButton(getDisplayChildByName("btn1"));
            this.btn1.setText(LanguageCfgObj.getInstance().getByIndex("10015", "lang_island"));
            this.btn2 = new BaseButton(getDisplayChildByName("btn2"));
            this.btn2.setText(LanguageCfgObj.getInstance().getByIndex("10016", "lang_island"));
            this.btn3 = new BaseButton(getDisplayChildByName("btn3"));
            this.btn3.setText(LanguageCfgObj.getInstance().getByIndex("10017", "lang_island"));
            this.btn4 = new BaseButton(getDisplayChildByName("btn4"));
            this.btn4.setText(LanguageCfgObj.getInstance().getByIndex("10018", "lang_island"));
            this.btnAry.push(this.btn1, this.btn2, this.btn3, this.btn4);
            this.list = new List(294, 180);
            this.addChild(this.list);
            this.list.move(18, 85);
            if (this.btn_close)
            {
                this.btn_close.addEventListener(MouseEvent.CLICK, this.__close, false, 0, true);
            }
            this.type = this._type;
            this.update();
            return;
        }// end function

        private function addEvents() : void
        {
            this.btn1.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn2.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn3.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            this.btn4.addEventListener(MouseEvent.CLICK, this.__click, false, 0, true);
            return;
        }// end function

        private function __close(event:MouseEvent = null) : void
        {
            super.close();
            return;
        }// end function

        private function __click(event:MouseEvent = null) : void
        {
            var _loc_2:* = this.btnAry.indexOf(event.target);
            if (this._type == (_loc_2 + 1))
            {
                return;
            }
            var _loc_3:* = 0;
            while (_loc_3 < this.btnAry.length)
            {
                
                if (this.btnAry[_loc_3] == event.target)
                {
                    this.btnAry[_loc_3].selected = true;
                }
                else
                {
                    this.btnAry[_loc_3].selected = false;
                }
                _loc_3++;
            }
            this._type = _loc_2 + 1;
            this.update();
            return;
        }// end function

        public function clear() : void
        {
            return;
        }// end function

        public function update() : void
        {
            this.setAwards();
            return;
        }// end function

        private function setAwards() : void
        {
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.list.reset();
            this.awardsHbox = new ListHBox();
            this.awardsHbox.oneRow = 5;
            this.awardsHbox.intervalX = 9;
            this.awardsHbox.intervalY = 4;
            this.awardsHbox.horizontal = true;
            var _loc_1:* = this.islandData["electments" + this._type];
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1.length)
            {
                
                _loc_3 = new IconItem("commonRewardBox2_40");
                _loc_4 = PropUtil.createItemByCfg(_loc_1[_loc_2].modelId);
                _loc_3.image.move(4, 3);
                _loc_3.setWH(46, 46);
                _loc_3.setInfo(_loc_4);
                _loc_3.count = _loc_1[_loc_2].num;
                this.awardsHbox.add(_loc_3);
                _loc_2++;
            }
            this.list.add(this.awardsHbox);
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        public function reqData() : void
        {
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            var _loc_2:* = 0;
            this._type = param1;
            if (UILoaded)
            {
                _loc_2 = 0;
                while (_loc_2 < this.btnAry.length)
                {
                    
                    if ((_loc_2 + 1) == param1)
                    {
                        this.btnAry[_loc_2].selected = true;
                    }
                    else
                    {
                        this.btnAry[_loc_2].selected = false;
                    }
                    _loc_2++;
                }
            }
            return;
        }// end function

    }
}
