<style>
*,*::before,*::after{box-sizing:border-box;margin:0;padding:0}html{scroll-behavior:smooth;font-size:16px}
:root{
  --black:<%= lawyer.brand.palette.black %>;
  --black-deep:<%= lawyer.brand.palette.blackDeep %>;
  --anthracite:<%= lawyer.brand.palette.anthracite %>;
  --border:<%= lawyer.brand.palette.border %>;
  --hairline:<%= lawyer.brand.palette.hairline %>;
  --gold:<%= lawyer.brand.palette.gold %>;
  --gold-h:<%= lawyer.brand.palette.goldHover %>;
  --white:<%= lawyer.brand.palette.white %>;
  --cream:<%= lawyer.brand.palette.cream %>;
  --grey:<%= lawyer.brand.palette.grey %>;
  --grey-d:<%= lawyer.brand.palette.greyDim %>;
  --gold-dim:rgba(201,168,76,.08);
  --gold-glow:rgba(201,168,76,.3);
  --font-serif:'<%= lawyer.brand.fonts.serif %>',Georgia,serif;
  --font-sans:'<%= lawyer.brand.fonts.sans %>',-apple-system,BlinkMacSystemFont,sans-serif;
}
body{font-family:var(--font-sans);background:var(--black);color:var(--white);-webkit-font-smoothing:antialiased;overflow-x:hidden;line-height:1.6}
[id]{scroll-margin-top:80px}
a{color:inherit}
.demo-banner{position:sticky;top:0;z-index:1001;background:linear-gradient(90deg,rgba(201,168,76,.15),rgba(201,168,76,.05));border-bottom:1px solid var(--gold);padding:10px clamp(16px,3vw,40px);font-size:12px;color:var(--cream);display:flex;align-items:center;justify-content:space-between;gap:16px;flex-wrap:wrap;letter-spacing:.02em}
.demo-banner b{color:var(--white)}
.demo-banner .demo-banner-tag{font-size:10px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);padding:4px 10px;border:1px solid var(--gold);border-radius:2px;white-space:nowrap}
.demo-banner a.demo-banner-cta{display:inline-flex;align-items:center;gap:6px;background:var(--gold);color:var(--black)!important;text-decoration:none;padding:6px 14px;font-weight:700;font-size:11px;letter-spacing:.06em;text-transform:uppercase;border-radius:2px;white-space:nowrap}
.demo-banner a.demo-banner-cta:hover{background:var(--gold-h)}
.nav{position:fixed;top:<%= h.isDemo ? '38px' : '0' %>;left:0;right:0;z-index:1000;height:72px;display:flex;align-items:center;padding:0 clamp(20px,5vw,80px);transition:background .4s,border-bottom .4s,top .3s;border-bottom:1px solid transparent;background:rgba(10,10,10,.6);backdrop-filter:blur(6px)}
.nav.scrolled{background:rgba(10,10,10,.92);border-bottom:1px solid var(--border)}
.nav-inner{display:flex;align-items:center;justify-content:space-between;width:100%;max-width:1200px;margin:0 auto}
.nav-logo{display:flex;align-items:center;gap:12px;text-decoration:none;color:var(--white)}
.nav-mark{width:38px;height:38px;background:var(--black);border:1.5px solid var(--gold);display:flex;align-items:center;justify-content:center;font-weight:800;font-size:13px;color:var(--gold);flex-shrink:0}
.nav-name{font-family:var(--font-serif);font-size:16px;font-weight:600;letter-spacing:-.005em;color:var(--white);line-height:1.2}.nav-role{font-size:11px;color:var(--grey-d);font-weight:400;letter-spacing:.03em;display:block}
.nav-links{display:flex;align-items:center;gap:32px;list-style:none}
.nav-links a{text-decoration:none;color:var(--grey);font-size:14px;font-weight:500;transition:color .2s}.nav-links a:hover{color:var(--white)}
.nav-cta{background:var(--gold)!important;color:var(--black)!important;font-weight:700!important;font-size:12px!important;letter-spacing:.08em!important;text-transform:uppercase;padding:11px 24px!important;transition:background .2s}
.nav-cta:hover{background:var(--gold-h)!important;box-shadow:0 0 20px var(--gold-glow)!important}
.btn{display:inline-flex;align-items:center;gap:10px;background:var(--gold);color:var(--black);font-family:'<%= lawyer.brand.fonts.sans %>',sans-serif;font-weight:700;font-size:.9rem;letter-spacing:.08em;text-transform:uppercase;padding:20px 52px;border:none;cursor:pointer;text-decoration:none;line-height:1;transition:background .3s,box-shadow .3s;border-radius:0;box-shadow:0 4px 28px rgba(201,168,76,.22)}
.btn:hover{background:var(--gold-h);box-shadow:0 6px 40px rgba(201,168,76,.45)}
.btn-ghost{display:inline-flex;align-items:center;gap:10px;background:transparent;color:var(--gold);border:1px solid var(--gold);font-weight:700;font-size:.85rem;letter-spacing:.08em;text-transform:uppercase;padding:16px 36px;text-decoration:none;line-height:1;transition:background .3s,color .3s}
.btn-ghost:hover{background:var(--gold);color:var(--black)}
.microcopy{font-size:.85rem;font-weight:300;color:var(--grey-d);display:flex;align-items:center;gap:6px;margin-top:14px}
.lbl{font-size:11px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);margin-bottom:14px;padding-left:12px;border-left:2px solid var(--gold)}
.st{font-size:clamp(1.9rem,3.5vw,2.6rem);font-weight:700;letter-spacing:-.03em;line-height:1.15;color:var(--white);margin-bottom:20px}.st em{font-style:normal;color:var(--gold)}
.bt{font-size:1.05rem;color:var(--grey);line-height:1.75;max-width:680px}
.sec{padding:100px clamp(20px,5vw,80px)}.wrap{max-width:1200px;margin:0 auto}
.hero{min-height:100vh;display:grid;grid-template-columns:60fr 40fr;background:var(--black);position:relative;overflow:hidden;padding-top:<%= h.isDemo ? '38px' : '0' %>}
.hero-left{display:flex;flex-direction:column;justify-content:center;padding:120px clamp(20px,5vw,80px) 80px;max-width:760px;position:relative;z-index:2}
.hero-badge{display:inline-flex;align-items:center;gap:10px;border:1px solid var(--border);padding:8px 18px;font-size:11px;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--gold);margin-bottom:32px;align-self:flex-start}
.hero-badge::before{content:'';width:5px;height:5px;border-radius:50%;background:var(--gold)}
.hero h1{font-family:var(--font-serif);font-size:clamp(2.6rem,5vw,4rem);font-weight:400;letter-spacing:-.01em;line-height:1.08;color:var(--white);margin-bottom:28px}
.hero h1 em{font-style:italic;font-weight:700;color:var(--gold)}
.hero-sub{font-size:clamp(1rem,1.8vw,1.15rem);color:var(--grey);max-width:560px;margin-bottom:44px;line-height:1.7}
.hero-right{position:relative;overflow:hidden;background:var(--anthracite)}
.hero-img{width:100%;height:100%;object-fit:cover;object-position:center top;display:block}
.hero-right::after{content:'';position:absolute;bottom:0;left:0;right:0;height:40%;background:linear-gradient(to top,var(--black),transparent);pointer-events:none}
.hero-right::before{content:'';position:absolute;top:0;left:0;bottom:0;width:80px;background:linear-gradient(to right,var(--black),transparent);pointer-events:none;z-index:1}
.cred-bar{background:var(--anthracite);border-top:1px solid var(--gold);border-bottom:1px solid var(--border);padding:0 clamp(20px,5vw,80px)}
.cred-inner{max-width:1200px;margin:0 auto;display:flex;align-items:stretch}
.cred-item{display:flex;flex-direction:column;align-items:center;justify-content:center;padding:36px 48px;border-right:1px solid var(--border);text-align:center;flex:1}.cred-item:last-child{border-right:none}
.cred-num{font-size:clamp(2rem,4vw,2.8rem);font-weight:800;letter-spacing:-.04em;color:var(--gold);line-height:1}
.cred-lbl{font-size:12px;color:#CECECE;font-weight:500;letter-spacing:.04em;text-transform:uppercase;margin-top:8px}
.areas-grid{display:grid;grid-template-columns:repeat(3,1fr);gap:24px;margin-top:48px}
.area-card{display:flex;flex-direction:column;background:#141414;border:1px solid #2A2A2A;padding:36px 28px;text-decoration:none;color:inherit;transition:border-color .25s,background .25s;position:relative;overflow:hidden}
.area-card::before{content:'';position:absolute;top:0;left:0;right:0;height:2px;background:var(--gold);opacity:.6}
.area-card:hover{background:#1a1a1a;border-color:var(--gold)}
.area-icon{width:44px;height:44px;border:1px solid var(--gold);display:flex;align-items:center;justify-content:center;color:var(--gold);margin-bottom:20px}
.area-title{font-family:var(--font-serif);font-size:1.2rem;font-weight:700;color:var(--white);margin-bottom:8px;letter-spacing:-.01em}
.area-desc{font-size:13px;color:var(--grey);line-height:1.65;flex:1}
.area-arrow{display:flex;align-items:center;gap:6px;margin-top:18px;color:var(--gold);font-size:11px;font-weight:700;letter-spacing:.12em;text-transform:uppercase}
.area-arrow svg{transition:transform .25s}
.area-card:hover .area-arrow svg{transform:translateX(4px)}
.form-card{background:var(--anthracite);border:1px solid var(--border);padding:44px 40px;max-width:520px}
.form-card-title{font-size:18px;font-weight:700;color:var(--white);letter-spacing:-.02em;margin-bottom:28px}
.form-group{margin-bottom:18px}
label{display:block;font-size:11px;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--grey-d);margin-bottom:8px}
input{background:var(--anthracite);border:1px solid var(--border);color:var(--white);padding:16px;font-family:var(--font-sans);font-size:1rem;width:100%;transition:border-color .3s;outline:none;border-radius:0}
input::placeholder{color:var(--grey-d)}input:focus{border-color:var(--gold);background:#191919}
.form-submit{width:100%;margin-top:6px;justify-content:center}
.form-gdpr{font-size:11px;color:var(--grey-d);margin-top:14px;line-height:1.6}
footer{background:var(--black-deep,#050505);border-top:1px solid var(--gold);padding:56px clamp(20px,5vw,80px) 40px}
.footer-grid{max-width:1200px;margin:0 auto;display:grid;grid-template-columns:1.5fr 1fr 1fr;gap:48px;padding-bottom:40px;border-bottom:1px solid var(--border)}
.footer-brand-name{font-size:16px;font-weight:700;color:var(--white);margin:12px 0 8px}
.footer-brand-desc{font-size:13px;color:#888;line-height:1.65;max-width:260px}
.footer-col-title{font-size:10px;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--grey-d);margin-bottom:16px}
.footer-col p,.footer-col address{font-size:13px;color:#888;font-style:normal;line-height:1.8}
.footer-col a{color:#888;text-decoration:none;transition:color .2s}.footer-col a:hover{color:var(--gold)}
.footer-bottom{max-width:1200px;margin:28px auto 0;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px}
.footer-legal{font-size:11px;color:var(--grey-d);line-height:1.6}
@media(max-width:1024px){.hero{grid-template-columns:1fr}.hero-right{display:none}}
@media(max-width:960px){.nav-links{display:none}.areas-grid{grid-template-columns:1fr}.footer-grid{grid-template-columns:1fr 1fr}}
@media(max-width:640px){.cred-inner{flex-direction:column}.cred-item{border-right:none;border-bottom:1px solid var(--border)}.cred-item:last-child{border-bottom:none}.footer-grid{grid-template-columns:1fr}}
</style>
