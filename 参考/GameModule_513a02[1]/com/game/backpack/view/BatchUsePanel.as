package com.game.backpack.view
{
    import com.f1.ui.*;
    import com.f1.ui.btn.*;
    import com.game.awardGuide.view.*;
    import com.model.vo.*;
    import com.view.icon.*;

    public class BatchUsePanel extends ItemAwardPanel
    {
        private var _info:PropInfo;
        private var _curNum:int;
        private var _layoutInfo:LayoutInfo;
        private var _icon:IconItem;
        private var _closeBtn:BaseButton;
        private var _okBtn:BaseButton;
        private var _cancelBtn:BaseButton;

        public function BatchUsePanel(param1 = null, param2:uint = 60, param3:String = "", param4:Boolean = true)
        {
            return;
        }// end function

        override protected function initUI() : void
        {
            super.initUI();
            return;
        }// end function

        override public function open() : void
        {
            super.open();
            return;
        }// end function

        override protected function openPanel() : void
        {
            updateView();
            return;
        }// end function

        override protected function closePanel() : void
        {
            info = null;
            return;
        }// end function

    }
}
