package com.game.operationpanel.view
{
    import __AS3__.vec.*;
    import com.f1.ui.*;
    import com.f1.ui.container.*;
    import com.model.*;
    import com.model.vo.*;
    import flash.display.*;
    import flash.events.*;

    public class SkillChoosePanel extends Component
    {
        private const VEC_BOX_LENGTH:int = 20;
        private var vecBox:Vector.<SkillBox>;
        private var hBox:HBox;
        public var callSelect:Function;
        private var shape:Shape;

        public function SkillChoosePanel(param1 = null, param2:String = null)
        {
            this.vecBox = new Vector.<SkillBox>(this.VEC_BOX_LENGTH, true);
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
            var _loc_2:* = null;
            this.hBox.horizontal = true;
            this.hBox.oneRow = 5;
            this.hBox.intervalX = 1;
            this.hBox.intervalY = 1;
            this.addChild(this.hBox);
            this.addEventListener(MouseEvent.CLICK, this.mouseClick);
            this.addEventListener(MouseEvent.MOUSE_OVER, this.mouseOver);
            this.addEventListener(MouseEvent.MOUSE_OUT, this.mouseOut);
            var _loc_1:* = 0;
            while (_loc_1 < this.VEC_BOX_LENGTH)
            {
                
                _loc_2 = new SkillBox("skillBoxBackSubBmp");
                this.vecBox[_loc_1] = _loc_2;
                _loc_1++;
            }
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
            if (event.target as SkillBox)
            {
                _loc_2 = event.target as SkillBox;
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
            if (event.target is SkillBox)
            {
                _loc_2 = event.target as SkillBox;
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

        public function resetSkills() : void
        {
            var _loc_2:* = 0;
            var _loc_3:* = null;
            var _loc_4:* = 0;
            var _loc_5:* = null;
            var _loc_1:* = UserObj.getInstance().playerInfo.skillList;
            if (_loc_1)
            {
                this.clean();
                _loc_2 = _loc_1.length;
                _loc_4 = 0;
                while (_loc_4 < _loc_2)
                {
                    
                    _loc_5 = _loc_1[_loc_4];
                    if (_loc_5.q_shortcut == 1 && _loc_5.q_trigger_type == 1)
                    {
                        _loc_3 = this.vecBox[_loc_4];
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
            var _loc_1:* = this.vecBox.length;
            var _loc_2:* = 0;
            while (_loc_2 < _loc_1)
            {
                
                if (this.vecBox[_loc_2])
                {
                    _loc_3 = this.vecBox[_loc_2];
                    if (_loc_3.parent)
                    {
                        _loc_3.clean();
                        this.hBox.remove(_loc_3);
                    }
                }
                _loc_2++;
            }
            return;
        }// end function

    }
}
