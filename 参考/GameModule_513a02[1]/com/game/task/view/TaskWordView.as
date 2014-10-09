package com.game.task.view
{
    import com.*;
    import com.f1.ui.*;
    import com.greensock.*;
    import flash.text.*;

    public class TaskWordView extends Component
    {
        private var stoped:Boolean = false;
        private var tweenLite:TweenLite;
        private var textView:TextField;
        private var text:String;
        public static var instance:TaskWordView;

        public function TaskWordView(param1:String)
        {
            if (instance)
            {
                instance.stop();
            }
            instance = this;
            mouseEnabled = false;
            mouseChildren = false;
            this.text = param1;
            loadDisplay("res/taskWordView.swf");
            return;
        }// end function

        override protected function displayReady() : void
        {
            if (this.stoped)
            {
                return;
            }
            initComponentUI("TaskWordView_text");
            this.textView = getDisplayChildByName("textView");
            var _loc_1:* = this.textView.defaultTextFormat;
            _loc_1.bold = true;
            this.textView.defaultTextFormat = _loc_1;
            this.textView.width = 1200;
            this.textView.text = this.text;
            setWH(this.width, this.height);
            Global.popManager.addTips(this, new LayoutInfo(Layout.BOTTOM_CENTER, 0, 131));
            this.tweenLite = new TweenLite(this, 1, {delay:8, alpha:0, onComplete:this.onTimeOut});
            super.displayReady();
            return;
        }// end function

        private function onTimeOut() : void
        {
            this.stop();
            return;
        }// end function

        public function stop() : void
        {
            if (this.stoped)
            {
                return;
            }
            this.stoped = true;
            instance = null;
            if (this.tweenLite)
            {
                this.tweenLite.kill();
            }
            if (UILoaded)
            {
                Global.popManager.removeTips(this);
            }
            finalize();
            return;
        }// end function

    }
}
