package com.game.operationpanel.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.container.*;
    import com.game.backpack.model.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class ShortcutChoosePanel extends Component
    {
        private var vecItem:Vector.<ShortcutBox>;
        private const VEC_BOX_LENGTH:int = 25;
        private var vecBox:Vector.<ShortcutBox>;
        private var hBox:HBox;
        private var skillhBox:HBox;
        public var callSelect:Function;
        private var shape:Shape;
        private var itemLen:int;

        public function ShortcutChoosePanel(param1 = null, param2:String = null)
        {
            this.vecItem = new Vector.<ShortcutBox>;
            this.vecBox = new Vector.<ShortcutBox>;
            this.hBox = new HBox();
            this.skillhBox = new HBox();
            this.shape = new Shape();
            super(param1, param2);
            this.initUI();
            this.initShape();
            return;
        }// end function

        private function initUI() : void
        {
            this.hBox.horizontal = true;
            this.hBox.oneRow = 6;
            this.hBox.intervalX = 1;
            this.hBox.intervalY = 1;
            this.addChild(this.hBox);
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            this.skillhBox.horizontal = true;
            this.skillhBox.oneRow = 6;
            this.skillhBox.intervalX = 1;
            this.skillhBox.intervalY = 1;
            this.addChild(this.skillhBox);
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
            if (event.target is ShortcutBox)
            {
                _loc_2 = event.target as ShortcutBox;
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
            if (event.target is ShortcutBox)
            {
                _loc_2 = event.target as ShortcutBox;
                if (!this.shape.parent)
                {
                    this.addChild(this.shape);
                }
                this.shape.x = _loc_2.x + _loc_2.parent.x;
                this.shape.y = _loc_2.y + _loc_2.parent.y;
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

        public function reset() : void
        {
            this.resetItems();
            this.resetSkills();
            this.layout();
            return;
        }// end function

        private function resetItems() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = BackpackObj.getInstance().getCanShortcutItem();
            if (_loc_1)
            {
                this.itemLen = 0;
                this.cleanItem();
                _loc_2 = _loc_1.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_5 = _loc_1[_loc_4];
                    if (_loc_5.q_shortcut == 1)
                    {
                        if (_loc_4 >= this.vecItem.length)
                        {
                            _loc_3 = new ShortcutBox("skillBoxBackSubBmp");
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
                        var _loc_6:* = this;
                        var _loc_7:* = this.itemLen + 1;
                        _loc_6.itemLen = _loc_7;
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function resetSkills() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.skillList;
            if (_loc_1)
            {
                this.cleanBox();
                _loc_2 = _loc_1.length;
                this.creatSkillBox(_loc_2);
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_5 = _loc_1[_loc_4];
                    if (_loc_5.q_shortcut == 1 && _loc_5.q_trigger_type == 1)
                    {
                        _loc_3 = this.vecBox[_loc_4];
                        _loc_3.info = _loc_5;
                        this.skillhBox.add(_loc_3);
                    }
                    _loc_4++;
                }
            }
            return;
        }// end function

        private function creatSkillBox(param1:int) : void
        {
            var _loc_4:* = null;
            var _loc_2:* = this.vecBox.length;
            var _loc_3:* = 0;
            while (_loc_3 < param1)
            {
                
                _loc_4 = new ShortcutBox("skillBoxBackSubBmp");
                _loc_4.canDrag = false;
                this.vecBox.push(_loc_4);
                _loc_3++;
            }
            return;
        }// end function

        private function layout() : void
        {
            this.skillhBox.y = 60 * Math.ceil(this.itemLen / 6);
            return;
        }// end function

        private function cleanItem() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = this.vecItem.length;
            _loc_2 = 0;
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

        private function cleanBox() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_1:* = this.vecBox.length;
            _loc_2 = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this.vecBox[_loc_2])
                {
                    _loc_3 = this.vecBox[_loc_2];
                    if (_loc_3.parent)
                    {
                        this.hBox.remove(_loc_3);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

        private function clean() : void
        {
            this.cleanItem();
            this.cleanBox();
            return;
        }// end function

    }
}
