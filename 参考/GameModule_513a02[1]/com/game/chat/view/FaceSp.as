package com.game.chat.view
{
    import com.*;
    import com.f1.*;
    import com.f1.utils.*;
    import com.game.chat.control.*;
    import com.greensock.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class FaceSp extends BaseSprite
    {
        private var _spArr:Array;
        private var _back:Sprite;
        private var _position:int;
        private static const ROW:int = 6;
        private static const COL:int = 5;
        private static var _inst:FaceSp;

        public function FaceSp()
        {
            var _loc_1:* = null;
            var _loc_2:* = 0;
            var _loc_3:* = null;
            this._spArr = [];
            this._back = ToolKit.getNew("generalHoverBg");
            this._back.width = 200;
            this._back.height = 200;
            addChild(this._back);
            _loc_2 = 0;
            while (_loc_2 < ChatInfo.FACELENGTH)
            {
                
                _loc_3 = ToolKit.getNew("face_" + ToolKit.add0((_loc_2 + 1), 2));
                _loc_3.name = "#" + ToolKit.add0((_loc_2 + 1), 2);
                _loc_3.mouseChildren = false;
                _loc_3.x = _loc_2 % 5 * 35 + 15;
                _loc_3.y = int(_loc_2 / 5) * 35 + 10;
                addChild(_loc_3);
                _loc_3.addEventListener(MouseEvent.MOUSE_DOWN, this.__mouseDown, false, 0, true);
                this._spArr.push(_loc_3);
                _loc_2++;
            }
            addEvtListener(Event.ADDED_TO_STAGE, this.__onStage);
            return;
        }// end function

        public function get position() : int
        {
            return this._position;
        }// end function

        public function set position(param1:int) : void
        {
            this._position = param1;
            return;
        }// end function

        private function __onStage(event:Event) : void
        {
            FrameworkGlobal.stage.addEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false, 0, true);
            return;
        }// end function

        private function __stageDown(event:MouseEvent) : void
        {
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown);
            event.stopImmediatePropagation();
            if (parent)
            {
                parent.removeChild(this);
            }
            return;
        }// end function

        private function __mouseDown(event:MouseEvent) : void
        {
            if (UserObj.getInstance().playerInfo.vipid > 0)
            {
                ChatController.getInstance().addFace(event.currentTarget.name, this.position);
            }
            else
            {
                Global.popManager.addedToMouseCue(LanguageCfgObj.getInstance().getByIndex("10467"));
            }
            FrameworkGlobal.stage.removeEventListener(MouseEvent.MOUSE_DOWN, this.__stageDown, false);
            event.stopPropagation();
            if (parent)
            {
                parent.removeChild(this);
            }
            TweenLite.delayedCall(1, this.addListener);
            return;
        }// end function

        private function addListener() : void
        {
            ChatController.getInstance().addOutListener();
            return;
        }// end function

        public static function get instance() : FaceSp
        {
            var _loc_1:* = new FaceSp;
            _inst = new FaceSp;
            return _inst || _loc_1;
        }// end function

    }
}
