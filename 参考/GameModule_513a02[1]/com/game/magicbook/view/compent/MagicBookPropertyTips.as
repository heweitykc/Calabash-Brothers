package com.game.magicbook.view.compent
{
    import com.f1.*;
    import com.f1.utils.*;
    import com.staticdata.*;
    import flash.display.*;
    import flash.text.*;
    import flash.utils.*;

    public class MagicBookPropertyTips extends BaseSprite
    {
        private var dic:Dictionary;
        private var _content:MovieClip;

        public function MagicBookPropertyTips()
        {
            this._content = ToolKit.getNew("magicBook_propertyTip");
            addChild(this._content);
            return;
        }// end function

        public function setInfo(param1:Dictionary, param2:Dictionary) : void
        {
            var _loc_3:* = 0;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            _loc_3 = param1[MagicBookPropertyType.ATK_MIN];
            _loc_4 = param2[MagicBookPropertyType.ATK_MIN];
            _loc_5 = this._content.getChildByName("p" + MagicBookPropertyType.ATK_MIN) as MovieClip;
            _loc_5.visible = _loc_3 < _loc_4;
            (_loc_5.getChildByName("text") as TextField).text = "+" + (_loc_4 - _loc_3).toString();
            _loc_3 = param1[MagicBookPropertyType.ATTACK_SPEED];
            _loc_4 = param2[MagicBookPropertyType.ATTACK_SPEED];
            _loc_5 = this._content.getChildByName("p" + MagicBookPropertyType.ATTACK_SPEED) as MovieClip;
            _loc_5.visible = _loc_3 < _loc_4;
            (_loc_5.getChildByName("text") as TextField).text = "+" + (_loc_4 - _loc_3).toString();
            _loc_3 = param1[MagicBookPropertyType.ATTACK_SUCCESS];
            _loc_4 = param2[MagicBookPropertyType.ATTACK_SUCCESS];
            _loc_5 = this._content.getChildByName("p" + MagicBookPropertyType.ATTACK_SUCCESS) as MovieClip;
            _loc_5.visible = _loc_3 < _loc_4;
            (_loc_5.getChildByName("text") as TextField).text = "+" + (_loc_4 - _loc_3).toString();
            _loc_3 = param1[MagicBookPropertyType.ATTACK_DEEP];
            _loc_4 = param2[MagicBookPropertyType.ATTACK_DEEP];
            _loc_5 = this._content.getChildByName("p" + MagicBookPropertyType.ATTACK_DEEP) as MovieClip;
            _loc_5.visible = _loc_3 < _loc_4;
            (_loc_5.getChildByName("text") as TextField).text = "+" + (_loc_4 - _loc_3) / 100 + "%";
            _loc_3 = param1[MagicBookPropertyType.INORGE_INFENCE];
            _loc_4 = param2[MagicBookPropertyType.INORGE_INFENCE];
            _loc_5 = this._content.getChildByName("p" + MagicBookPropertyType.INORGE_INFENCE) as MovieClip;
            _loc_5.visible = _loc_3 < _loc_4;
            (_loc_5.getChildByName("text") as TextField).text = "+" + (_loc_4 - _loc_3) / 100 + "%";
            return;
        }// end function

        override public function finalize() : void
        {
            super.finalize();
            return;
        }// end function

    }
}
