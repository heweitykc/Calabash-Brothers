package com.f1.utils.cue
{
    import com.f1.*;
    import com.greensock.*;
    import flash.utils.*;

    public class StatusSystemCue extends BaseSprite
    {
        private var arrNotice:Array;
        private var item:ScrollSystemItem;
        private var delayHandler:uint;

        public function StatusSystemCue()
        {
            this.arrNotice = new Array();
            return;
        }// end function

        public function addInfoToCue(param1:String) : void
        {
            if (!this.item)
            {
                this.item = new ScrollSystemItem();
                this.item.type = ScrollSystemCue.SYSTEM_NOTICE;
            }
            if (!this.item.parent)
            {
                this.addChild(this.item);
            }
            this.arrNotice.push(param1);
            this.nestItem();
            return;
        }// end function

        private function nestItem() : void
        {
            clearTimeout(this.delayHandler);
            TweenMax.killChildTweensOf(this);
            this.item.alpha = 0;
            this.item.htmlText = this.arrNotice.pop() as String;
            TweenMax.to(this.item, 1.5, {alpha:1});
            this.delayHandler = setTimeout(this.stop, 5000);
            this.item.x = (-this.item.width) / 2;
            return;
        }// end function

        private function stop() : void
        {
            if (this.arrNotice.length > 0)
            {
                this.nestItem();
            }
            else
            {
                TweenMax.to(this.item, 1.5, {alpha:0, onComplete:this.clean});
                clearTimeout(this.delayHandler);
            }
            return;
        }// end function

        private function clean() : void
        {
            this.item.parent.removeChild(this.item);
            return;
        }// end function

    }
}
