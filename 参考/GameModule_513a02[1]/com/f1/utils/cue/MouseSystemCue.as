package com.f1.utils.cue
{
    import com.f1.*;
    import com.greensock.*;
    import flash.utils.*;

    public class MouseSystemCue extends BaseSprite
    {
        private var arrNotice:Array;
        private var item:ScrollSystemItem;
        private var delayHandler:uint;

        public function MouseSystemCue()
        {
            this.arrNotice = new Array();
            return;
        }// end function

        public function addInfoToCue(param1:String) : void
        {
            if (!this.item)
            {
                this.item = new ScrollSystemItem();
                this.addChild(this.item);
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
            this.item.x = -1 * this.item.width / 2;
            this.item.y = 0;
            TweenMax.to(this.item, 0.2, {alpha:1, y:-100});
            this.delayHandler = setTimeout(this.stop, 2000);
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
                TweenMax.to(this.item, 0.2, {alpha:0, y:0, onComplete:this.clean});
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
