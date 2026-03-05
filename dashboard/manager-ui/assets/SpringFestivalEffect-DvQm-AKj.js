import{r as i,j as t}from"./index-D7_sMdyA.js";const x=({onClose:o})=>{const[s,r]=i.useState(!1);i.useEffect(()=>{requestAnimationFrame(()=>r(!0));const a=setTimeout(()=>n(),5e3);return()=>clearTimeout(a)},[]);const n=()=>{r(!1),setTimeout(o,500)},e=({text:a,style:l})=>t.jsx("div",{className:"lantern-box",style:l,children:t.jsxs("div",{className:"lantern-light",children:[t.jsx("div",{className:"lantern-line"}),t.jsx("div",{className:"lantern-circle",children:t.jsx("div",{className:"lantern-rect",children:t.jsx("div",{className:"lantern-text",children:a})})}),t.jsxs("div",{className:"lantern-tassel-top",children:[t.jsx("div",{className:"lantern-tassel-middle"}),t.jsx("div",{className:"lantern-tassel-bottom"})]})]})});return t.jsxs("div",{className:`fixed inset-0 z-[9999] pointer-events-auto transition-opacity duration-500 ease-in-out ${s?"opacity-100":"opacity-0"}`,onClick:n,children:[t.jsx("div",{className:"absolute inset-0 bg-black/10 backdrop-blur-[1px]"}),t.jsx("style",{children:`
                /* 移植用户 CSS */
                .lantern-box {
                    position: fixed;
                    pointer-events: none;
                    z-index: 10000;
                }
                .lantern-light {
                    position: relative;
                    width: 120px;
                    height: 90px;
                    background-color: #d8000f;
                    margin: 50px;
                    border-radius: 50%;
                    box-shadow: -5px 5px 50px 4px #fa6c00;
                    animation: swing 3s infinite ease-in-out;
                    transform-origin: top center;
                }
                .lantern-light::before,.lantern-light::after {
                    content:"";
                    position: absolute;
                    border:1px solid #dc8f03;
                    width: 60px;
                    height: 12px;
                    background: linear-gradient(to right,#dc8f03,#ffa500,#dc8f03,#ffa500,#dc8f03);
                    margin-left: 20px;
                    left: 10px;
                }
                .lantern-light::before{
                    top: -7px;
                    border-top-left-radius: 5px;
                    border-top-right-radius: 5px;
                }
                .lantern-light::after {
                    bottom: -7px;
                    border-bottom-left-radius: 5px;
                    border-bottom-right-radius: 5px;
                }
                .lantern-line {
                    width: 2px;
                    height: 50px;
                    background-color: #dc8f03;
                    position: absolute;
                    top: -50px;
                    left: 60px;
                }
                .lantern-circle,.lantern-rect {
                    height: 90px;
                    border-radius: 50%;
                    border: 2px solid #dc8f03;
                    background-color: rgba(216,0,15,.1);
                }
                .lantern-circle {
                    width: 100px;
                    margin:12px 0px 0px 8px; /* 微调以适配 React 渲染 */
                }
                .lantern-rect {
                    margin: -2px 0px 0px 25px; /* 微调 */
                    width: 45px;
                }
                .lantern-text {
                    font: bold 2rem / 85px 'Franklin Gothic Medium', 'Arial Narrow', Arial, sans-serif;
                    text-align: center;
                    color: #dc8f03;
                    margin-top: 4px; /* 微调文字垂直居中 */
                }
                .lantern-tassel-top {
                    width: 5px;
                    height: 20px;
                    background-color: #ffa500;
                    border-radius: 0 0 5px 5px;
                    position: relative;
                    margin:-5px 0 0 59px;
                    animation: swing 3s infinite ease-in-out;
                }
                .lantern-tassel-middle,.lantern-tassel-bottom {
                    position: absolute;
                    width: 10px;
                    left: -2px;
                }
                .lantern-tassel-middle{
                    border-radius: 50%;
                    top: 14px;
                    height: 10px;
                    background-color: #dc8f03;
                    z-index: 2;
                }
                .lantern-tassel-bottom  {
                    background-color: #ffa500;
                    border-bottom-left-radius: 5px;
                    height: 35px;
                    top: 18px;
                    z-index: 1;
                }
                @keyframes swing {
                    0% { transform: rotate(-10deg); }
                    50% { transform: rotate(10deg); }
                    100% { transform: rotate(-10deg); }
                }

                /* 响应式调整 */
                @media (max-width: 768px) {
                    .lantern-box {
                        transform: scale(0.6); /* 移动端整体缩小 */
                    }
                    /* 移动端调整位置 */
                    .lantern-mobile-hide { display: none; }
                }
            `}),t.jsx(e,{text:"新",style:{left:"2%",top:"-30px",animationDelay:"-0.5s"}}),t.jsx(e,{text:"年",style:{left:"160px",top:"-25px"}}),t.jsx("div",{className:"hidden md:block",children:t.jsx(e,{text:"快",style:{right:"160px",top:"-28px",animationDelay:"-0.8s"}})}),t.jsx(e,{text:"乐",style:{right:"2%",top:"-26px",animationDelay:"-0.2s"}})]})};export{x as default};
