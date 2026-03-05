<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Minimal Dark Unix Desktop</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=JetBrains+Mono:wght@400;700&family=Inter:wght@300;400;500;600&display=swap');

        :root {
            --bg-dark: #0b0e14;
            --panel-bg: rgba(15, 17, 26, 0.75);
            --accent: #7aa2f7;
            --border: rgba(255, 255, 255, 0.05);
            --glass-blur: blur(20px);
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-dark);
            /* Wallpaper oscuro minimalista */
            background-image: url('https://images.unsplash.com/photo-1477346611705-65d1883cee1e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover;
            background-position: center;
            height: 100vh;
            overflow: hidden;
            color: #a9b1d6;
        }

        .glass {
            background: var(--panel-bg);
            backdrop-filter: var(--glass-blur);
            border: 1px solid var(--border);
        }

        .mono { font-family: 'JetBrains Mono', monospace; }

        /* Estilo de ventanas minimalistas sin bordes */
        .window-frame {
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0,0,0,0.6);
            border: 1px solid rgba(255,255,255,0.03);
        }

        /* Barra de estado en Tmux */
        .tmux-status {
            background: #1a1b26;
            font-size: 0.7rem;
            color: #565f89;
        }
        .tmux-current {
            color: #7aa2f7;
            border-bottom: 2px solid #7aa2f7;
            padding: 0 10px;
        }

        /* Ocultar centro de notificaciones por defecto */
        #notif-center {
            transform: translateX(100%);
            transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        #notif-center.open {
            transform: translateX(0);
        }

        /* Pestañas laterales */
        .tab-content { display: none; }
        .tab-content.active { display: block; }

        /* Sliders minimalistas */
        input[type=range] {
            -webkit-appearance: none;
            background: rgba(255,255,255,0.1);
            height: 4px;
            border-radius: 2px;
        }
        input[type=range]::-webkit-slider-thumb {
            -webkit-appearance: none;
            height: 12px;
            width: 12px;
            border-radius: 50%;
            background: #7aa2f7;
            cursor: pointer;
        }

        @keyframes pulse-soft {
            0%, 100% { opacity: 1; }
            50% { opacity: 0.5; }
        }
        .cursor-blink { animation: pulse-soft 1s infinite; }
    </style>
</head>
<body class="flex flex-col h-screen">

    <!-- BARRA SUPERIOR (Status Bar) -->
    <header class="w-full h-10 glass flex items-center justify-between px-6 z-50 text-[11px] mono">
        <div class="flex items-center space-x-6">
            <div class="flex space-x-3 items-center">
                <span class="text-[#7aa2f7] font-bold"></span>
                <span class="opacity-100 bg-white/5 px-2 rounded">1</span>
                <span class="opacity-40 hover:opacity-100 transition cursor-pointer">2</span>
                <span class="opacity-40 hover:opacity-100 transition cursor-pointer">3</span>
            </div>
            <div class="flex items-center space-x-2 border-l border-white/5 pl-6 text-gray-500">
                <i class="fa-solid fa-window-maximize text-[10px]"></i>
                <span class="font-medium text-gray-300">alacritty: tmux</span>
            </div>
        </div>

        <div class="flex items-center space-x-6">
            <div class="flex items-center space-x-2">
                <span class="text-[#f7768e]"></span>
                <span id="cpu-stat">08%</span>
            </div>
            <div class="flex items-center space-x-2">
                <span class="text-[#9ece6a]"></span>
                <span id="ram-stat">1.8GiB</span>
            </div>
            <div class="flex items-center space-x-2">
                <span class="text-[#e0af68]">󰔄</span>
                <span>38°C</span>
            </div>
            <div class="flex items-center space-x-4 border-l border-white/5 pl-6">
                <span class="text-[#bb9af7]"><i class="fa-solid fa-wifi"></i></span>
                <span class="text-gray-400 font-bold" id="clock-display">15:30</span>
                <button onclick="toggleNotif()" class="hover:text-[#7aa2f7] transition">
                    <i class="fa-solid fa-sliders"></i>
                </button>
            </div>
        </div>
    </header>

    <main class="flex-1 flex overflow-hidden p-3 gap-3 relative">
        
        <!-- BARRA LATERAL IZQUIERDA (IA & TRADUCTOR) -->
        <aside class="w-72 glass window-frame flex flex-col z-40">
            <div class="flex h-12 border-b border-white/5">
                <button onclick="setTab('ai')" id="tab-btn-ai" class="flex-1 flex items-center justify-center space-x-2 text-xs font-medium border-b-2 border-[#7aa2f7] bg-white/5">
                    <i class="fa-solid fa-brain"></i> <span>AI</span>
                </button>
                <button onclick="setTab('trans')" id="tab-btn-trans" class="flex-1 flex items-center justify-center space-x-2 text-xs font-medium border-b-2 border-transparent hover:bg-white/5 transition">
                    <i class="fa-solid fa-language"></i> <span>Trad</span>
                </button>
            </div>

            <div class="flex-1 p-4 flex flex-col overflow-hidden">
                <!-- AI Panel -->
                <div id="panel-ai" class="tab-content active h-full flex flex-col">
                    <div id="ai-chat" class="flex-1 overflow-y-auto space-y-4 mb-4 text-[13px] leading-relaxed pr-2">
                        <div class="text-[#7aa2f7] font-bold text-[10px] uppercase tracking-wider">Gemini Session</div>
                        <div class="text-gray-400 bg-white/5 p-3 rounded-lg border border-white/5">
                            Bienvenido al kernel 6.1. ¿Cómo puedo asistirte en tu flujo de trabajo?
                        </div>
                    </div>
                    <div class="relative mt-auto">
                        <input type="text" id="ai-query" placeholder="Type prompt..." class="w-full bg-[#1a1b26] border border-white/5 rounded-lg py-2 px-3 text-xs outline-none focus:border-[#7aa2f7]/50 transition">
                        <button onclick="sendToAI()" class="absolute right-3 top-2.5 text-[#7aa2f7]"><i class="fa-solid fa-paper-plane text-[10px]"></i></button>
                    </div>
                </div>

                <!-- Translator Panel -->
                <div id="panel-trans" class="tab-content h-full flex flex-col">
                    <div class="flex items-center justify-between mb-3 text-[10px] font-bold opacity-50 uppercase">
                        <span>ES</span> <i class="fa-solid fa-arrow-right"></i> <span>EN</span>
                    </div>
                    <textarea class="w-full h-32 bg-[#1a1b26] border border-white/5 rounded-lg p-3 text-xs outline-none focus:border-[#7aa2f7]/50 resize-none mb-4" placeholder="Input text..."></textarea>
                    <div class="p-3 bg-white/5 rounded-lg border border-white/5 text-xs text-gray-500 italic">
                        La traducción aparecerá aquí instantáneamente...
                    </div>
                </div>
            </div>
        </aside>

        <!-- AREA CENTRAL (Terminal) -->
        <section class="flex-1 flex items-center justify-center">
            <div class="window-frame glass w-full h-[85%] max-w-5xl flex flex-col">
                <!-- Terminal Header -->
                <div class="h-9 bg-black/20 flex items-center px-4 justify-between">
                    <div class="flex space-x-1.5">
                        <div class="w-2.5 h-2.5 rounded-full bg-[#f7768e]/40"></div>
                        <div class="w-2.5 h-2.5 rounded-full bg-[#e0af68]/40"></div>
                        <div class="w-2.5 h-2.5 rounded-full bg-[#9ece6a]/40"></div>
                    </div>
                    <div class="text-[10px] mono opacity-40">alacritty — user@arch-minimal</div>
                    <div class="w-10"></div>
                </div>

                <!-- Terminal Body -->
                <div class="flex-1 p-6 mono text-[13px] leading-6 overflow-y-auto bg-[#0b0e14]/40">
                    <div class="flex items-center space-x-2">
                        <span class="text-[#9ece6a]">󰈺</span>
                        <span class="text-[#7aa2f7]">~</span>
                        <span class="text-white">ls -la</span>
                    </div>
                    <div class="text-gray-500 grid grid-cols-4 gap-2 mt-2">
                        <span>drwxr-xr-x</span> <span>.config</span>
                        <span>drwxr-xr-x</span> <span>.local</span>
                        <span>-rw-r--r--</span> <span>.zshrc</span>
                        <span>drwxr-xr-x</span> <span>projects</span>
                    </div>
                    <div class="mt-4 flex items-center space-x-2">
                        <span class="text-[#9ece6a]">󰈺</span>
                        <span class="text-[#7aa2f7]">~/projects</span>
                        <span class="w-2 h-5 bg-[#7aa2f7] cursor-blink"></span>
                    </div>
                </div>

                <!-- Tmux Footer -->
                <div class="h-6 tmux-status flex items-center justify-between px-3 font-medium">
                    <div class="flex items-center h-full">
                        <span class="text-[#9ece6a] mr-3">[0]</span>
                        <div class="flex h-full">
                            <span class="px-3 opacity-40">1:zsh</span>
                            <span class="tmux-current flex items-center h-full">2:nvim*</span>
                            <span class="px-3 opacity-40">3:btop</span>
                        </div>
                    </div>
                    <div class="flex items-center space-x-4">
                        <span class="text-[9px] uppercase tracking-tighter opacity-50">"main_session"</span>
                        <span class="text-[#7dcfff]">15:30:45</span>
                    </div>
                </div>
            </div>
        </section>

        <!-- CENTRO DE NOTIFICACIONES (Derecha) -->
        <aside id="notif-center" class="absolute right-0 top-0 h-full w-80 glass border-l border-white/5 p-6 flex flex-col z-50 window-frame">
            <div class="flex justify-between items-center mb-8">
                <span class="text-xs font-bold uppercase tracking-[2px]">System Control</span>
                <button onclick="toggleNotif()" class="text-gray-500 hover:text-white"><i class="fa-solid fa-xmark"></i></button>
            </div>

            <!-- Quick Toggles -->
            <div class="grid grid-cols-2 gap-3 mb-8">
                <div class="bg-[#7aa2f7] text-black p-3 rounded-xl flex items-center space-x-3 cursor-pointer">
                    <i class="fa-solid fa-wifi"></i>
                    <div class="flex flex-col"><span class="text-[9px] font-bold leading-none">WIFI</span><span class="text-[8px] opacity-70">On</span></div>
                </div>
                <div class="bg-white/5 p-3 rounded-xl flex items-center space-x-3 cursor-pointer hover:bg-white/10 transition">
                    <i class="fa-solid fa-bluetooth text-[#bb9af7]"></i>
                    <div class="flex flex-col"><span class="text-[9px] font-bold leading-none">BT</span><span class="text-[8px] opacity-70">Off</span></div>
                </div>
                <div class="bg-white/5 p-3 rounded-xl flex items-center space-x-3 cursor-pointer hover:bg-white/10 transition">
                    <i class="fa-solid fa-moon text-[#e0af68]"></i>
                    <div class="flex flex-col"><span class="text-[9px] font-bold leading-none">DND</span><span class="text-[8px] opacity-70">Off</span></div>
                </div>
                <div class="bg-white/10 p-3 rounded-xl flex items-center space-x-3 cursor-pointer">
                    <i class="fa-solid fa-rotate text-[#9ece6a]"></i>
                    <div class="flex flex-col"><span class="text-[9px] font-bold leading-none">UPD</span><span class="text-[8px] opacity-70">Ready</span></div>
                </div>
            </div>

            <!-- Volume & Brightness Sliders -->
            <div class="space-y-6 mb-8">
                <div class="space-y-2">
                    <div class="flex justify-between text-[10px] uppercase font-bold opacity-40"><span>Brightness</span><span>85%</span></div>
                    <input type="range" class="w-full" value="85">
                </div>
                <div class="space-y-2">
                    <div class="flex justify-between text-[10px] uppercase font-bold opacity-40"><span>Volume</span><span>60%</span></div>
                    <input type="range" class="w-full accent-[#7aa2f7]" value="60">
                </div>
            </div>

            <!-- Audio Control Card -->
            <div class="bg-black/30 rounded-xl p-4 mb-8 border border-white/5">
                <div class="flex items-center space-x-4">
                    <div class="w-10 h-10 bg-[#7aa2f7]/20 rounded-lg flex items-center justify-center text-[#7aa2f7]">
                        <i class="fa-solid fa-music"></i>
                    </div>
                    <div class="flex-1">
                        <div class="text-[11px] font-bold text-gray-200">Lofi Hip Hop</div>
                        <div class="text-[9px] text-gray-500">Night Owl Radio</div>
                    </div>
                </div>
                <div class="flex justify-center space-x-6 mt-4 text-xs opacity-60">
                    <i class="fa-solid fa-backward-step cursor-pointer hover:opacity-100"></i>
                    <i class="fa-solid fa-play cursor-pointer hover:opacity-100"></i>
                    <i class="fa-solid fa-forward-step cursor-pointer hover:opacity-100"></i>
                </div>
            </div>

            <!-- Mini Calendar -->
            <div class="mt-auto pt-4 border-t border-white/5">
                <div class="text-center mb-4 text-[10px] font-bold text-[#7aa2f7]">FEBRERO 2026</div>
                <div class="grid grid-cols-7 gap-1 text-[9px] text-center">
                    <span class="opacity-30">L</span><span class="opacity-30">M</span><span class="opacity-30">M</span><span class="opacity-30">J</span><span class="opacity-30">V</span><span class="opacity-30">S</span><span class="opacity-30">D</span>
                    <span class="py-1">11</span><span class="py-1">12</span><span class="py-1">13</span><span class="py-1">14</span><span class="py-1">15</span><span class="py-1">16</span><span class="py-1 bg-[#7aa2f7] text-black rounded-md font-bold">17</span>
                </div>
            </div>
        </aside>

    </main>

    <script>
        // Update clock and stats
        function updateStats() {
            const now = new Date();
            document.getElementById('clock-display').textContent = now.toLocaleTimeString('es-ES', { hour: '2-digit', minute: '2-digit' });
            
            // Simulación de carga de sistema
            const cpu = Math.floor(Math.random() * 15) + 5;
            document.getElementById('cpu-stat').textContent = `${cpu.toString().padStart(2, '0')}%`;
        }
        setInterval(updateStats, 1000);
        updateStats();

        // Notification Center Toggle
        function toggleNotif() {
            document.getElementById('notif-center').classList.toggle('open');
        }

        // Tab Switcher
        function setTab(tab) {
            const tabs = ['ai', 'trans'];
            tabs.forEach(t => {
                document.getElementById(`panel-${t}`).classList.remove('active');
                document.getElementById(`tab-btn-${t}`).classList.remove('border-[#7aa2f7]', 'bg-white/5');
                document.getElementById(`tab-btn-${t}`).classList.add('border-transparent');
            });
            
            document.getElementById(`panel-${tab}`).classList.add('active');
            document.getElementById(`tab-btn-${tab}`).classList.add('border-[#7aa2f7]', 'bg-white/5');
            document.getElementById(`tab-btn-${tab}`).classList.remove('border-transparent');
        }

        // AI Chat Simulation
        const apiKey = "";
        async function sendToAI() {
            const input = document.getElementById('ai-query');
            const chat = document.getElementById('ai-chat');
            const text = input.value.trim();
            if(!text) return;

            const userDiv = document.createElement('div');
            userDiv.className = "text-white text-[12px] opacity-80 border-l-2 border-white/20 pl-3";
            userDiv.innerHTML = `<span class="text-[9px] text-gray-500 font-bold block uppercase">User</span>${text}`;
            chat.appendChild(userDiv);
            input.value = "";

            try {
                const response = await fetch(`https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-preview-09-2025:generateContent?key=${apiKey}`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ contents: [{ parts: [{ text: text }] }] })
                });
                const data = await response.json();
                const aiResponse = data.candidates?.[0]?.content?.parts?.[0]?.text || "System error: No response.";
                
                const aiDiv = document.createElement('div');
                aiDiv.className = "text-[#7aa2f7] text-[12px] bg-[#7aa2f7]/5 p-3 rounded-lg border border-[#7aa2f7]/10";
                aiDiv.innerHTML = `<span class="text-[9px] font-bold block uppercase mb-1">Gemini</span>${aiResponse.split('\n')[0]}...`;
                chat.appendChild(aiDiv);
                chat.scrollTop = chat.scrollHeight;
            } catch (e) {
                console.error(e);
            }
        }

        document.getElementById('ai-query').addEventListener('keypress', (e) => { if(e.key === 'Enter') sendToAI(); });
    </script>
</body>
</html>