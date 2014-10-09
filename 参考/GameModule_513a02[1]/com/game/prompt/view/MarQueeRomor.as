package com.game.prompt.view
{
    import __AS3__.vec.*;
    import com.*;
    import com.f1.*;
    import com.f1.interfaces.*;
    import com.f1.ui.*;
    import com.game.backpack.control.*;
    import com.game.chat.model.*;
    import com.game.chat.view.*;
    import com.game.prompt.control.*;
    import com.game.prompt.utils.*;
    import com.game.utils.*;
    import com.greensock.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filters.*;
    import flash.text.*;
    import flash.utils.*;

    public class MarQueeRomor extends BaseSprite implements IMarquee
    {
        private var visibleWidth:int;
        private var _marqueeTxt:TextField;
        private var _marqueeMask:Shape;
        private var _panel:BaseSprite;
        private var _layout:LayoutInfo;
        private var _info:ChatSimpleVo;
        private var tips:BaseTips;
        private var tipsTimeoutId:int;
        private static var MAX_WORDS:uint = 50;
        private static var WIDTH:int;
        private static var HEIGHT:int;
        private static const SHOW_TIME:int = 15;
        private static const STAY_TIME:int = 5;
        private static const SCROLL_SPEED:int = 33;
        private static const TIPS_TIME:int = 10000;

        public function MarQueeRomor()
        {
            this.init();
            this.addEvent();
            return;
        }// end function

        public function get layout() : LayoutInfo
        {
            return this._layout;
        }// end function

        public function set layout(param1:LayoutInfo) : void
        {
            this._layout = param1;
            return;
        }// end function

        private function addEvent() : void
        {
            FrameworkGlobal.stage.addEventListener(Event.RESIZE, this.onResize);
            addEventListener(TextEvent.LINK, this.__link);
            return;
        }// end function

        protected function onResize(event:Event) : void
        {
            this._panel.mask = this._marqueeMask;
            Global.popManager.addToMainScreen(this, this._layout);
            return;
        }// end function

        private function init() : void
        {
            this.mouseChildren = false;
            this.mouseEnabled = false;
            this._panel = new BaseSprite();
            this._marqueeTxt = new TextField();
            this._marqueeTxt.defaultTextFormat = new TextFormat(LanguageCfgObj.getInstance().getByIndex("11088"), 16, 65280, true);
            this._marqueeTxt.autoSize = TextFieldAutoSize.LEFT;
            this._marqueeTxt.selectable = false;
            this._marqueeTxt.multiline = false;
            this._marqueeTxt.wordWrap = false;
            this._marqueeTxt.mouseWheelEnabled = false;
            this._marqueeTxt.filters = [new GlowFilter(0, 1, 3, 3, 3, 4)];
            computeSize(this._marqueeTxt);
            this._marqueeMask = new Shape();
            this._marqueeMask.graphics.beginFill(16711680);
            this._marqueeMask.graphics.drawRect(0, 0, 1, HEIGHT);
            this._marqueeMask.graphics.endFill();
            this._marqueeMask.filters = [new BlurFilter(50, 0)];
            this._panel.addChild(this._marqueeTxt);
            this.addChild(this._panel);
            this.addChild(this._marqueeMask);
            this._panel.mask = this._marqueeMask;
            return;
        }// end function

        public function addedInfo(param1:String, param2:Vector.<String> = null, param3:Vector.<GoodsInfoRes> = null) : void
        {
            if (!param1)
            {
                return;
            }
            this._info = PromptUtil.getInstance().transMsgToObject(param1, param2, param3);
            this._marqueeTxt.htmlText = this._info.content;
            this.visibleWidth = Math.min(this._marqueeTxt.width, WIDTH);
            setWH(this.visibleWidth, HEIGHT);
            Global.popManager.addToMainScreen(this, this._layout);
            this.startShow();
            return;
        }// end function

        private function startShow() : void
        {
            var _loc_1:* = NaN;
            var _loc_2:* = NaN;
            var _loc_3:* = NaN;
            var _loc_4:* = NaN;
            this.dispearTips();
            TweenMax.killChildTweensOf(this);
            this._marqueeMask.width = 1;
            this._marqueeMask.x = this.visibleWidth / 2;
            TweenMax.to(this._marqueeMask, 0.5, {width:this.visibleWidth, x:0});
            TweenMax.to(this._marqueeMask, 0.5, {delay:SHOW_TIME, width:0, x:this.visibleWidth / 2});
            this._marqueeTxt.x = 0;
            if (this._marqueeTxt.width > this.visibleWidth)
            {
                _loc_1 = this._marqueeTxt.width - this.visibleWidth;
                _loc_2 = _loc_1 / SCROLL_SPEED;
                _loc_3 = STAY_TIME;
                _loc_4 = SHOW_TIME - _loc_3;
                if (_loc_2 > _loc_4)
                {
                    _loc_2 = _loc_4;
                    _loc_1 = _loc_2 * SCROLL_SPEED;
                }
                TweenMax.to(this._marqueeTxt, _loc_2, {delay:_loc_3, ease:easeUniformSpeed, x:-_loc_1});
            }
            return;
        }// end function

        private function __link(event:TextEvent) : void
        {
            var _loc_2:* = null;
            var _loc_3:* = null;
            var _loc_4:* = null;
            this.dispearTips();
            _loc_2 = event.text.split("|");
            switch(_loc_2[0])
            {
                case "item":
                {
                    _loc_3 = this.getProp(_loc_2[1], _loc_2[2]);
                    this.tips = EquipCompareControl.createEquipTips(_loc_3, true);
                    this.tipsTimeoutId = setTimeout(this.dispearTips, TIPS_TIME);
                    break;
                }
                case "user":
                {
                    _loc_4 = new PlayerInfo();
                    _loc_4.name = _loc_2[1];
                    _loc_4.personId = long.parselong(_loc_2[2]);
                    ChatPopMenu.getInstance().show(_loc_4, FrameworkGlobal.stage);
                    break;
                }
                case "map":
                {
                    PromptControl.getInstance().openOtherPanel(_loc_2[2]);
                    break;
                }
                default:
                {
                    break;
                }
            }
            return;
        }// end function

        private function dispearTips() : void
        {
            if (this.tips)
            {
                clearTimeout(this.tipsTimeoutId);
                EquipCompareControl.removeTips(this.tips);
                this.tips = null;
            }
            return;
        }// end function

        private function getProp(param1:Number, param2:int) : PropInfo
        {
            var _loc_3:* = long.parselong(param1.toString());
            var _loc_4:* = 0;
            while (_loc_4 < this._info.goods.length)
            {
                
                if (long.isZero(_loc_3))
                {
                    if ((this._info.goods[_loc_4] as PropInfo).itemModelId == param2)
                    {
                        return this._info.goods[_loc_4];
                    }
                }
                else if ((this._info.goods[_loc_4] as PropInfo).itemId.equal(_loc_3))
                {
                    return this._info.goods[_loc_4];
                }
                _loc_4++;
            }
            return null;
        }// end function

        private static function computeSize(param1:TextField) : void
        {
            if (WIDTH != 0)
            {
                return;
            }
            var _loc_2:* = "";
            var _loc_3:* = 0;
            while (_loc_3 < MAX_WORDS)
            {
                
                _loc_2 = _loc_2 + "字";
                _loc_3 = _loc_3 + 1;
            }
            param1.text = _loc_2;
            WIDTH = param1.width;
            HEIGHT = param1.height;
            param1.text = "";
            return;
        }// end function

        private static function easeUniformSpeed(param1:Number, param2:Number, param3:Number, param4:Number) : Number
        {
            return param1 / param4;
        }// end function

    }
}
