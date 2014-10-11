package com.f1.manager.cursor
{
    import __AS3__.vec.*;
    import com.f1.interfaces.manager.*;
    import com.f1.utils.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;

    public class PrimaryCursorManager extends Object implements IPrimaryCursorManager
    {
        private var _stage:Stage;
        private static var hasInit:Boolean = false;

        public function PrimaryCursorManager(param1:Stage)
        {
            this._stage = param1;
            this.init();
            return;
        }// end function

        private function init() : void
        {
            var _loc_1:* = null;
            var _loc_2:* = null;
            var _loc_3:* = null;
            if (!hasInit)
            {
                hasInit = true;
                _loc_1 = ToolKit.getNew("Cursorhand");
                _loc_2 = new MouseCursorData();
                _loc_2.hotSpot = new Point(0, 0);
                _loc_3 = new Vector.<BitmapData>;
                _loc_3[0] = _loc_1;
                _loc_2.data = _loc_3;
                _loc_2.frameRate = 7;
                Mouse.registerCursor("Cursorhand", _loc_2);
                _loc_3[0] = ToolKit.getNew("Cursorid");
                Mouse.registerCursor("Cursorid", _loc_2);
                _loc_3[0] = ToolKit.getNew("sell");
                Mouse.registerCursor("sell", _loc_2);
                _loc_3[0] = ToolKit.getNew("drag");
                Mouse.registerCursor("drag", _loc_2);
                _loc_3[0] = ToolKit.getNew("trade");
                Mouse.registerCursor("trade", _loc_2);
                _loc_3[0] = ToolKit.getNew("Cursordontmove");
                Mouse.registerCursor("Cursordontmove", _loc_2);
                _loc_3[0] = ToolKit.getNew("Cursorattack");
                Mouse.registerCursor("Cursorattack", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorGet");
                Mouse.registerCursor("CursorGet", _loc_2);
                _loc_3[0] = ToolKit.getNew("protectItemMark");
                Mouse.registerCursor("CursorLock", _loc_2);
                _loc_3[0] = ToolKit.getNew("Cursordakong");
                Mouse.registerCursor("Cursordakong", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorExtract");
                Mouse.registerCursor("CursorExtract", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorClick1");
                Mouse.registerCursor("CursorClick1", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorClick2");
                Mouse.registerCursor("CursorClick2", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorClick1");
                _loc_3[1] = ToolKit.getNew("CursorClick2");
                Mouse.registerCursor("CursorClick", _loc_2);
                _loc_3[0] = ToolKit.getNew("CursorTalk1");
                _loc_3[1] = ToolKit.getNew("CursorTalk2");
                _loc_3[2] = ToolKit.getNew("CursorTalk3");
                _loc_3[3] = ToolKit.getNew("CursorTalk4");
                _loc_3[4] = ToolKit.getNew("CursorTalk5");
                _loc_3[5] = ToolKit.getNew("CursorTalk6");
                Mouse.registerCursor("CursorTalk", _loc_2);
                Mouse.cursor = "CursorClick1";
                this._stage.addEventListener(MouseEvent.MOUSE_DOWN, this.downClickHandler);
                this._stage.addEventListener(MouseEvent.MOUSE_UP, this.upClickHandler);
                this.shieldRightMouse();
            }
            return;
        }// end function

        private function downClickHandler(event:MouseEvent) : void
        {
            if (Mouse.cursor == "CursorClick1")
            {
                Mouse.cursor = "CursorClick2";
            }
            if (event.target is InteractiveObject)
            {
                this._stage.focus = InteractiveObject(event.target);
            }
            return;
        }// end function

        private function upClickHandler(event:MouseEvent) : void
        {
            if (Mouse.cursor == "CursorClick2")
            {
                Mouse.cursor = "CursorClick1";
            }
            return;
        }// end function

        private function shieldRightMouse() : void
        {
            this._stage.addEventListener("rightClick", this.rightMouseClickHandler);
            return;
        }// end function

        private function rightMouseClickHandler(event:MouseEvent) : void
        {
            return;
        }// end function

        public function showHandIcon() : void
        {
            Mouse.cursor = "Cursorhand";
            return;
        }// end function

        public function showDragIcon() : void
        {
            Mouse.cursor = "drag";
            return;
        }// end function

        public function showCursoridIcon() : void
        {
            Mouse.cursor = "Cursorid";
            return;
        }// end function

        public function showTradeIcon() : void
        {
            Mouse.cursor = "trade";
            return;
        }// end function

        public function showSellIcon() : void
        {
            Mouse.cursor = "sell";
            return;
        }// end function

        public function showNotMoveIcon() : void
        {
            Mouse.cursor = "Cursordontmove";
            return;
        }// end function

        public function showAttackIcon() : void
        {
            Mouse.cursor = "Cursorattack";
            return;
        }// end function

        public function showClickIcon() : void
        {
            Mouse.cursor = "CursorClick";
            return;
        }// end function

        public function showTalkIcon() : void
        {
            Mouse.cursor = "CursorTalk";
            return;
        }// end function

        public function showGetIcon() : void
        {
            Mouse.cursor = "CursorGet";
            return;
        }// end function

        public function showDakongIcon() : void
        {
            Mouse.cursor = "Cursordakong";
            return;
        }// end function

        public function showExtractIcon() : void
        {
            Mouse.cursor = "CursorExtract";
            return;
        }// end function

        public function hide() : void
        {
            Mouse.cursor = "CursorClick1";
            return;
        }// end function

        public function showLock() : void
        {
            Mouse.cursor = "CursorLock";
            return;
        }// end function

    }
}
