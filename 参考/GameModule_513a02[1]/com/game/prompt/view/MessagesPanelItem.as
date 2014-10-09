package com.game.prompt.view
{
    import com.f1.*;
    import com.f1.interfaces.ui.list.*;
    import com.f1.ui.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.game.chat.model.*;
    import com.game.utils.*;
    import com.model.vo.*;
    import com.view.tipcell.*;
    import flash.events.*;
    import flash.text.*;

    public class MessagesPanelItem extends Component implements IItem
    {
        private var _info:ChatSimpleVo;
        private var _timeTxt:TextField;
        private var _itemTxt:TextField;
        private var tips:BaseTips;

        public function MessagesPanelItem(param1 = null, param2:String = null)
        {
            var _loc_3:* = null;
            super(param1, param2);
            this._timeTxt = new TextField();
            this._timeTxt.autoSize = "left";
            _loc_3 = this._timeTxt.defaultTextFormat;
            _loc_3.leading = 1;
            _loc_3.font = "SimSun";
            this._timeTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._timeTxt.defaultTextFormat = _loc_3;
            this._timeTxt.textColor = 8681295;
            addChild(this._timeTxt);
            this._itemTxt = new TextField();
            _loc_3 = this._itemTxt.defaultTextFormat;
            this._itemTxt.width = 230;
            this._itemTxt.multiline = true;
            this._itemTxt.wordWrap = true;
            _loc_3.leading = 1;
            _loc_3.font = "SimSun";
            this._itemTxt.filters = [FrameworkGlobal.BLACK_FILTER];
            this._itemTxt.defaultTextFormat = _loc_3;
            this._itemTxt.textColor = 16766079;
            this._itemTxt.x = 125;
            var _loc_4:* = 2;
            this._timeTxt.y = 2;
            this._itemTxt.y = _loc_4;
            addChild(this._itemTxt);
            return;
        }// end function

        public function get key()
        {
            return;
        }// end function

        public function get obj()
        {
            return;
        }// end function

        public function set info(param1) : void
        {
            this._info = param1;
            this._timeTxt.text = ToolKit.parseSecond2Date(this._info.time);
            this._itemTxt.htmlText = param1.content;
            this._itemTxt.height = this._itemTxt.textHeight + 6;
            this._itemTxt.addEventListener(TextEvent.LINK, this.__link);
            return;
        }// end function

        public function set obj(param1) : void
        {
            if (!param1)
            {
                return;
            }
            this.info = param1;
            return;
        }// end function

        public function get label() : String
        {
            return "";
        }// end function

        private function __link(event:TextEvent) : void
        {
            TextLinkControl.getInstance().doLink(event.text);
            return;
        }// end function

        private function __stageClick(event:MouseEvent) : void
        {
            if (this.tips && this.tips.parent)
            {
                this.tips.parent.removeChild(this.tips);
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

        public function setSelected(param1:Boolean, param2:Boolean = true) : void
        {
            return;
        }// end function

        public function get selected() : Boolean
        {
            return false;
        }// end function

    }
}
