package com.game.gameStrategy.view
{
    import com.f1.ui.*;
    import com.f1.ui.scroller.*;

    public class FunctionOpenView extends Component
    {
        private var _scrollpanel:ScrollPanel;
        private var _view1:Object;

        public function FunctionOpenView()
        {
            this._view1 = getDisplayChildByName("view1");
            initComponentUI("gameStrategy_functionOpen");
            this.move(10, 78);
            this.initUI();
            return;
        }// end function

        private function initUI() : void
        {
            this._scrollpanel = new ScrollPanel(567, 218);
            this._scrollpanel.move(30, 83);
            addChildAt(this._scrollpanel, 1);
            this._scrollpanel.content = getDisplayChildByName("view1");
            this._scrollpanel.scrollTo(0);
            return;
        }// end function

    }
}
