package com.game.operationpanel.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.container.*;
    import com.game.backpack.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class ItemChoosePanel extends Component
    {
        private var vecItem:Vector.<ItemShortcutBox>;
        private var hBox:HBox;
        public var callSelect:Function;
        private var shape:Shape;

        public function ItemChoosePanel(param1 = null, param2:String = null)
        {
            this.vecItem = new Vector.<ItemShortcutBox>;
            this.hBox = new HBox();
            this.shape = new Shape();
            super(param1, param2);
            this.initUI();
            this.initShape();
            return;
        }// end function

        override protected function displayReady() : void
        {
            super.displayReady();
            return;
        }// end function

        private function initUI() : void
        {
            this.hBox.horizontal = true;
            this.hBox.oneRow = 5;
            this.hBox.intervalX = 1;
            this.hBox.intervalY = 1;
            this.addChild(this.hBox);
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            return;
        }// end function

        private function initShape() : void
        {
            this.shape.graphics.lineStyle(2, 16776960);
            this.shape.graphics.drawRect(2, 2, 56, 56);
            return;
        }// end function

        private function mouseClick(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target is ItemShortcutBox)
            {
                _loc_2 = event.target as ItemShortcutBox;
                if (this.callSelect != null)
                {
                    this.callSelect(_loc_2);
                }
            }
            return;
        }// end function

        private function mouseOver(event:MouseEvent) : void
        {
            var _loc_2:* = null;
            if (event.target is ItemShortcutBox)
            {
                _loc_2 = event.target as ItemShortcutBox;
                if (!this.shape.parent)
                {
                    this.addChild(this.shape);
                }
                this.shape.x = _loc_2.x;
                this.shape.y = _loc_2.y;
            }
            return;
        }// end function

        private function mouseOut(event:MouseEvent) : void
        {
            if (this.shape.parent)
            {
                this.shape.parent.removeChild(this.shape);
            }
            return;
        }// end function

        public function resetItems() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = BackpackObj.getInstance().getCanShortcutItem();
            if (_loc_1)
            {
                this.clean();
                _loc_2 = _loc_1.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_5 = _loc_1[_loc_4];
                    if (_loc_5.q_shortcut == 1)
                    {
                        if (_loc_4 >= this.vecItem.length)
                        {
                            _loc_3 = new ItemShortcutBox("skillBoxBackSubBmp");
                            _loc_3.setImageSize(48, 48);
                            _loc_3.isMenu = false;
                            _loc_3.isDrag = false;
                            this.vecItem[_loc_4] = _loc_3;
                        }
                        else
                        {
                            _loc_3 = this.vecItem[_loc_4];
                        }
                        _loc_3.info = _loc_5;
                        this.hBox.add(_loc_3);
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function clean() : void
        {
            var _loc_3:* = null;
            var _loc_1:* = this.vecItem.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this.vecItem[_loc_2])
                {
                    _loc_3 = this.vecItem[_loc_2];
                    if (_loc_3.parent)
                    {
                        this.hBox.remove(_loc_3);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

    }
}
