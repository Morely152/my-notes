# Role: Senior UI/UX Designer specialized in Meditation & Sleep Apps

# Context: 
Project "Floating Dream" (浮境) MVP version. 
Objective: Create a high-fidelity design for a sleep-aid app focused on "AI-Generated Stories" and "Ambient Sounds." 
The style must be "Deep & Warm" to minimize blue light and eye strain.

# Global Style Constraints:
- Background: Deep Navy (#0F172A) or Deep Moss Green (#06130B). Strictly no #000000.
- Accent: Moonlight Gold (#FDE047) or Soft Sage (#D2E3C8).
- Text: Light Grey-Blue (#E2E8F0) for main, Muted Grey (#94A3B8) for sub. No pure #FFFFFF.
- Texture: Neumorphism (soft shadows) for buttons, Glassmorphism (backdrop-blur: 20px) for cards.
- Radius: Large rounded corners (32px+).

# Pages to Design via Pencil MCP:

## Page 1: Ambient Discovery (Home)
- Layout: 3-column grid of cards.
- Content: Cards with blurred thumbnails and icons (Rain, Fire, Forest).
- Bottom: A glassmorphism persistent player bar with Play/Pause and a tiny volume indicator.

## Page 2: AI Story Generator (Interactive Mode)
- Visual Style: Dialogue-based flow.
- Components:
  - "What story do you want?" prompt area.
  - Keyword chips (e.g., "Ancient China", "Sci-fi", "Nature") with neumorphic toggle states.
  - A "Dreaming" progress circle (for LLM generation feedback) with a slow glowing animation.

## Page 3: The "Remote Control" Control Center (Core UX)
- Layout: Split view (Top 20% / Bottom 80%).
- Top 20%: A large Sleep Timer button showing "Remaining: 30:00".
- Bottom 80% (Split Left/Right):
  - Left Panel (Ambient): Large icon in center, vertical volume track background.
  - Right Panel (Story): Large icon in center, vertical volume track background.
- UI Logic: High touch-area surface; minimal text; tactile visual feedback.

## Page 4: User Profile (MVP Version)
- Content: User avatar, Username, "Credits: 120".
- Actions: List items for "My Stories", "Recharge Credits", "System Settings".

# Technical Requirement for Pencil:
1. Use 24dp page margins.
2. Render neumorphic shadows using light (#FFFFFF 0.02) and dark (rgba(0,0,0,0.4)) offsets.
3. Ensure touch targets for all buttons are at least 48x48dp.
4. Draw one variant using the "Deep Ocean" theme and one using "Midnight Forest".

Please generate the visual screens now using the Pencil tool.