package com.game.shop.view
{
    import com.f1.manager.timer.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.f1.ui.container.*;
    import com.f1.utils.*;
    import com.game.map.control.*;
    import com.game.shop.control.*;
    import com.game.shop.model.*;
    import com.model.*;
    import com.model.vo.*;
    import com.view.icon.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class SuperValueBuyPanel extends BaseBox
    {
        private var _box:HBox;
        private var _orginTxt:TextField;
        private var _nowTxt:TextField;
        private var _titleTimeTxt:TextField;
        private var _timeTxt:TextField;
        private var _confirmBtn:BaseButton;
        private var _cancelBtn:BaseButton;
        private var _closeBtn:BaseButton;
        private var _prop:PropInfo;
        private var _info:SupervalueInfo;
        private const _startPoint:Point;
        private const CONTAINERWIDTH:int = 336;
        private var _lineSp:Sprite;
        private var _count:int;

        public function SuperValueBuyPanel()
        {
            this._startPoint = new Point(38, 52);
            loadDisplay("res/supervaluepanel.swf");
            return;
        }// end function

        public function get prop() : PropInfo
        {
            return this._prop;
        }// end function

        public function set prop(param1:PropInfo) : void
        {
            this._prop = param1;
            this._info = new SupervalueInfo();
            this._info.itemId = this._prop.itemModelId;
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("supervaluepanel");
            this.initUI();
            this.addlistener();
            if (this._info)
            {
                this.update();
            }
            super.displayReady();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            if (UILoaded)
            {
                this.clearPanel();
                if (this._info)
                {
                    this.update();
                }
            }
            return;
        }// end function

        private function clearPanel() : void
        {
            this._orginTxt.text = "";
            this._nowTxt.text = "";
            var _loc_1:* = this._box.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                this._box.removeByIndex(0);
                _loc_2++;
            }
            return;
        }// end function

        private function __btnClick(event:MouseEvent) : void
        {
            switch(event.target)
            {
                case this._confirmBtn:
                {
                    if (this._info.nowPrice <= UserObj.getInstance().playerInfo.gold)
                    {
                        ShopController.getInstance().buySuperValue(this._prop);
                        this.close();
                    }
                    else
                    {
                        MapControl.getInstance().showRechargeD();
                    }
                    break;
                }
                case this._cancelBtn:
                {
                    this.close();
                    break;
                }
                case this._closeBtn:
                {
                    this.close();
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        override public function close() : void
        {
            super.close();
            Ticker.killTimer(this.updateEffectTime);
            return;
        }// end function

        private function addlistener() : void
        {
            this._cancelBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._confirmBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__btnClick);
            return;
        }// end function

        private function updateEffectTime() : void
        {
            this._timeTxt.text = ToolKit.second2CountDown(this._count);
            return;
        }// end function

        private function initUI() : void
        {
            this._orginTxt = getDisplayChildByName("txt_orgin");
            this._nowTxt = getDisplayChildByName("txt_now");
            this._confirmBtn = new BaseButton(getDisplayChildByName("btn_confirm"));
            this._cancelBtn = new BaseButton(getDisplayChildByName("btn_cancel"));
            this._timeTxt = getDisplayChildByName("txt_time");
            this._titleTimeTxt = getDisplayChildByName("txt_title");
            this._closeBtn = new BaseButton(getDisplayChildByName("closeBtn"));
            this._box = new HBox();
            this._box.horizontal = true;
            addChild(this._box);
            this._lineSp = new Sprite();
            this._lineSp.graphics.lineStyle(2, 16711680);
            this._lineSp.graphics.moveTo(0, 9);
            this._lineSp.graphics.lineTo(this._orginTxt.width, 9);
            this._lineSp.graphics.endFill();
            this._lineSp.x = this._orginTxt.x;
            this._lineSp.y = this._orginTxt.y;
            addChild(this._lineSp);
            return;
        }// end function

        private function endCount() : void
        {
            this.close();
            return;
        }// end function

        private function update() : void
        {
            var _loc_2:* = null;
            var _loc_3:* = 0;
            this._orginTxt.text = ToolKit.getMoneyString(this._info.orginalPrice);
            this._nowTxt.text = ToolKit.getMoneyString(this._info.nowPrice);
            var _loc_1:* = 0;
            while (_loc_1 < this._info.goods.length)
            {
                
                _loc_2 = new IconItem("commoniconitembg");
                _loc_2.setImageXY(4, 4);
                _loc_2.setInfo(this._info.goods[_loc_1]);
                this._box.add(_loc_2);
                _loc_1++;
            }
            Ticker.killTimer(this.updateEffectTime);
            if (this._prop.lostTime)
            {
                _loc_3 = this._prop.lostTime - ToolKit.getServerTime() * 0.001;
                if (_loc_3 > 0)
                {
                    Ticker.registerTimer(1, this.updateEffectTime, this.endCount, _loc_3);
                    this._timeTxt.textColor = 15564081;
                    this._count = _loc_3;
                    this.updateEffectTime();
                }
                this._timeTxt.visible = true;
                this._titleTimeTxt.visible = true;
            }
            else
            {
                this._timeTxt.visible = false;
                this._titleTimeTxt.visible = false;
            }
            this._box.x = (this.CONTAINERWIDTH - this._box.width) * 0.5;
            this._box.y = this._startPoint.y;
            return;
        }// end function

    }
}
