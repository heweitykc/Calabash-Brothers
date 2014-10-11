package com.game.login.view
{
    import com.f1.*;
    import com.f1.utils.*;
    import flash.display.*;

    public class VirtualChat extends BaseSprite
    {
        private var _mask:Shape;
        private var _positionY:Number = 0;
        private var _content:BaseSprite;
        private var _high:Number;

        public function VirtualChat(param1:Number, param2:Number)
        {
            this._high = param2;
            this._content = new BaseSprite();
            addChild(this._content);
            this._mask = new Shape();
            this._mask.graphics.beginFill(0, 0);
            this._mask.graphics.drawRect(0, 0, 1, 1);
            this._mask.graphics.endFill();
            this._mask.width = param1 + 2;
            this._mask.height = param2 + 2;
            this._mask.x = this._content.x - 1;
            addChild(this._mask);
            this._content.mask = this._mask;
            this.mouseChildren = false;
            this.mouseEnabled = false;
            return;
        }// end function

        public function set objs(param1:Array) : void
        {
            var _loc_3:* = null;
            this.reset();
            var _loc_2:* = param1.length;
            var _loc_4:* = 0;
            while (_loc_4 < _loc_2)
            {
                
                _loc_3 = new ChatItem();
                _loc_3.obj = param1[_loc_4];
                _loc_3.y = this._positionY;
                _loc_3.x = 0;
                this._positionY = this._positionY + (_loc_3.height <= 20 ? (16) : (_loc_3.height));
                this._content.addChild(_loc_3);
                _loc_4++;
            }
            if (this._positionY > this._high)
            {
                this._content.y = this._high - this._positionY;
            }
            else
            {
                this._content.y = 0;
            }
            return;
        }// end function

        private function reset() : void
        {
            this._positionY = 0;
            ToolKit.clearMcChild(this._content);
            return;
        }// end function

    }
}

import com.f1.*;

import com.f1.utils.*;

import flash.display.*;

class ChatItem extends ListItem
{
    private var _txt:TextField;

    function ChatItem() : void
    {
        super("regist_namelogo", "");
        return;
    }// end function

    override protected function getComp() : void
    {
        this._txt = _content.getChildByName("txt") as TextField;
        this._txt.wordWrap = true;
        this._txt.autoSize = TextFieldAutoSize.RIGHT;
        return;
    }// end function

    override protected function receive() : void
    {
        _content.gotoAndStop(obj.q_channel);
        var _loc_1:* = obj.q_player_name && obj.q_player_name != "" ? ("[" + obj.q_player_name + "]") : ("");
        this._txt.htmlText = "<font color =\'#FFDE00\'>" + _loc_1 + "</font><font color =\'#ffffff\'>" + obj.q_main + "</font>";
        return;
    }// end function

}

