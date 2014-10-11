package com.game.guide.view
{
    import com.*;
    import com.f1.*;
    import com.f1.ui.*;
    import com.f1.ui.box.*;
    import com.f1.ui.btn.*;
    import com.game.guide.control.*;
    import com.model.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.*;

    public class FunGuidePanel extends BaseBox
    {
        private var _activite:Boolean;
        private const _startPoint:Point;
        private const WH:Array;
        private var _class:String;
        private var _type:int;
        private var _btn:BmpButton;
        private var _illustrateTxt:TextField;
        protected var _closeBtn:BaseButton;
        private var _info:Object;
        private var _layoutInfo:LayoutInfo;

        public function FunGuidePanel(param1 = null, param2:String = null)
        {
            this._startPoint = new Point(185, 70);
            this.WH = [150, 60];
            super.loadDisplay("res/funcguide.swf");
            return;
        }// end function

        public function get activite() : Boolean
        {
            return this._activite;
        }// end function

        public function set activite(param1:Boolean) : void
        {
            this._activite = param1;
            return;
        }// end function

        public function get type() : int
        {
            return this._type;
        }// end function

        public function set type(param1:int) : void
        {
            this._type = param1;
            if (UILoaded)
            {
                this.update();
            }
            return;
        }// end function

        private function update() : void
        {
            var _loc_2:* = null;
            var _loc_1:* = FunGuideControl.getInstance().TEMPLETE;
            switch(this._type)
            {
                case FunGuideControl.getInstance().SELL:
                {
                    _loc_2 = _loc_1[this.type];
                    this._class = LanguageCfgObj.getInstance().getByIndex("10725");
                    break;
                }
                case FunGuideControl.getInstance().ITEM_EXPANSION:
                {
                    _loc_2 = _loc_1[this.type];
                    this._class = LanguageCfgObj.getInstance().getByIndex("10726");
                    break;
                }
                case FunGuideControl.getInstance().SELF_SHOP:
                {
                    _loc_2 = _loc_1[this.type];
                    this._class = LanguageCfgObj.getInstance().getByIndex("10727");
                    break;
                }
                case FunGuideControl.getInstance().TALENT:
                {
                    _loc_2 = (_loc_1[this.type] as String).replace("{1}", UserObj.getInstance().playerInfo.unallocatedTalent);
                    this._class = LanguageCfgObj.getInstance().getByIndex("10728");
                    break;
                }
                default:
                {
                    break;
                }
            }
            this._btn.setText(this._class);
            this._illustrateTxt.width = 175;
            this._illustrateTxt.htmlText = _loc_2;
            if (this._illustrateTxt.textWidth < 160)
            {
                this._illustrateTxt.width = this._illustrateTxt.textWidth + 4;
            }
            this._illustrateTxt.height = this._illustrateTxt.textHeight + 4;
            this.updatePos();
            return;
        }// end function

        private function updatePos() : void
        {
            this._illustrateTxt.x = this._startPoint.x + (this.WH[0] - this._illustrateTxt.width >> 1);
            this._illustrateTxt.y = this._startPoint.y + (this.WH[1] - this._illustrateTxt.height >> 1);
            if (this._illustrateTxt.numLines > 2)
            {
                this._btn.x = 218;
            }
            else
            {
                this._btn.x = 218;
            }
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.initBaseBoxUI("funcguide");
            this.initUI();
            this.addlisteners();
            if (this._type)
            {
                this.update();
            }
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this._illustrateTxt = getDisplayChildByName("txt_illustrate");
            this._illustrateTxt.width = 175;
            this._illustrateTxt.textColor = 16766079;
            this._closeBtn = new BaseButton(getDisplayChildByName("close_btn"));
            this._btn = new BmpButton(getDisplayChildByName("ok_btn"));
            return;
        }// end function

        private function addlisteners() : void
        {
            this._closeBtn.addEvtListener(MouseEvent.CLICK, this.__close);
            this._btn.addEvtListener(MouseEvent.CLICK, this.__click);
            return;
        }// end function

        private function __click(event:MouseEvent) : void
        {
            FunGuideControl.getInstance().openGuide(this._type);
            this.__close();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            this.openPanel();
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

        public function __close(event:MouseEvent = null) : void
        {
            Global.popManager.removeUI(this);
            this._activite = false;
            FunGuideControl.getInstance().removeGuide(this);
            return;
        }// end function

    }
}
