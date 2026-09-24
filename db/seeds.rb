# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Provisions the first admin from ENV vars, so credentials never land in source control.
# Usage: ADMIN_EMAIL=you@example.com ADMIN_PASSWORD=changeme bin/rails db:seed
if (email = ENV["ADMIN_EMAIL"]) && (password = ENV["ADMIN_PASSWORD"])
  admin = Admin.find_or_initialize_by(email: email)
  admin.password = password
  admin.save!
  puts "Admin account ready: #{email}"
else
  puts "Skipping admin seed — set ADMIN_EMAIL and ADMIN_PASSWORD to create/update one."
end

# Demo portfolio projects with placeholder images, just to preview the layout.
# Safe to re-run — skips any project that already exists.
def seed_project(slug:, title:, description:, image_filename:, features:, technologies: [])
  if Project.exists?(slug: slug)
    puts "Skipping demo project — '#{title}' already exists."
    return
  end

  image_path = Rails.root.join("app/assets/images/placeholders/#{image_filename}")

  project = Project.new(
    title: title,
    description: description,
    published: true,
    features_attributes: features,
    technology_list: technologies.join(", ")
  )

  project.image.attach(io: File.open(image_path), filename: "#{slug}-cover.jpg", content_type: "image/jpeg")
  project.save!

  project.features.each_with_index do |feature, index|
    feature.image.attach(io: File.open(image_path), filename: "feature-#{index + 1}.jpg", content_type: "image/jpeg")
  end

  puts "Demo project ready: #{title} (#{project.features.count} features)"
end

seed_project(
  slug: "how-to-boil-water",
  title: "How to Boil Water",
  description: "Boiling water is one of the most fundamental cooking skills. " \
    "Follow these steps to get a perfect rolling boil every time.",
  image_filename: "project_placeholder.jpg",
  features: [
    { title: "Fill a pot with water", description: "Choose a pot that fits how much water you need, and fill it about two-thirds full with a kitchen faucet or filtered water." },
    { title: "Place the pot on the stove", description: "Set the pot on a burner that matches its size and make sure it's centered for even heating." },
    { title: "Turn the heat to high", description: "Turn the dial to high heat. Covering the pot with a lid traps steam and helps it boil faster." },
    { title: "Wait for a rolling boil", description: "Watch for big, rapid bubbles breaking the surface continuously — that's a rolling boil, not just a simmer." },
    { title: "Turn off the heat", description: "Once it's boiling, turn off the burner (or reduce the heat) as needed for whatever you're cooking." }
  ],
  technologies: [ "Ruby on Rails", "PostgreSQL", "Bootstrap" ]
)

seed_project(
  slug: "how-to-fold-a-paper-crane",
  title: "How to Fold a Paper Crane",
  description: "The origami crane is a classic symbol of peace and good luck. " \
    "All you need is a single square sheet of paper and a few careful folds.",
  image_filename: "example.jpg",
  features: [
    { title: "Start with a square sheet", description: "Place your paper color-side down on a flat surface, oriented like a diamond in front of you." },
    { title: "Fold the diagonals", description: "Fold the paper in half corner to corner, unfold, then fold corner to corner the other way and unfold, leaving an X-shaped crease." },
    { title: "Collapse into a square base", description: "Turn the paper color-side up and fold it in half to form a triangle, unfold, then fold in half the other way. Bring the sides together to collapse it into a smaller square." },
    { title: "Fold and unfold the kite shapes", description: "On the top layer, fold both outer edges in to meet the center line, then unfold to leave crease marks. Repeat on the back." },
    { title: "Petal fold to make the neck and tail", description: "Lift the bottom point up along the creases, using the crease marks to flatten the sides inward. Repeat on the back so you have two long points." },
    { title: "Shape the head and wings", description: "Fold one point's tip down to form the head, then gently pull the wings apart and curve them outward until the crane stands on its own." }
  ],
  technologies: [ "Ruby on Rails", "Tailwind CSS" ]
)

seed_project(
  slug: "how-to-tie-a-bowline-knot",
  title: "How to Tie a Bowline Knot",
  description: "The bowline forms a secure loop that won't slip or bind under load, " \
    "yet unties easily even after being pulled tight. A must-know knot for sailing, climbing, or camping.",
  image_filename: "project_placeholder.jpg",
  features: [
    { title: "Make a small loop", description: "Form a small loop in the rope a short distance from the end — this becomes the 'rabbit hole' the working end passes through." },
    { title: "Bring the working end up through the loop", description: "Picture the working end as a rabbit coming up out of its hole, through the small loop from behind." },
    { title: "Wrap around the standing line", description: "The 'rabbit' goes around the standing part of the rope (the tree trunk), circling all the way around." },
    { title: "Send it back down the hole", description: "Feed the working end back down through the small loop it originally came out of, following the rabbit back into its hole." },
    { title: "Tighten the knot", description: "Hold the loop steady and pull the standing line and working end apart to cinch the knot snug." }
  ],
  technologies: [ "Ruby on Rails", "PostgreSQL" ]
)

seed_project(
  slug: "how-to-brew-pour-over-coffee",
  title: "How to Brew Pour-Over Coffee",
  description: "Pour-over brewing gives you full control over extraction for a clean, " \
    "flavorful cup. It just takes a filter, a kettle, and a little patience.",
  image_filename: "example.jpg",
  features: [
    { title: "Rinse the filter", description: "Place a paper filter in the dripper and rinse it with hot water to remove papery taste and preheat the vessel." },
    { title: "Add ground coffee", description: "Add medium-fine ground coffee to the filter, roughly 1 gram of coffee for every 16 grams of water." },
    { title: "Bloom the grounds", description: "Pour just enough hot water (around 200°F) to saturate the grounds and let it sit for 30-45 seconds while it releases gas." },
    { title: "Pour in slow circles", description: "Continue pouring in slow, steady circles from the center outward, keeping the water level consistent." },
    { title: "Let it drain and serve", description: "Once all the water has passed through, remove the dripper and enjoy your coffee while it's hot." }
  ],
  technologies: [ "Ruby on Rails", "React", "Bootstrap" ]
)

seed_project(
  slug: "how-to-change-a-bike-tire",
  title: "How to Change a Bike Tire",
  description: "A flat tire doesn't have to end your ride. With a spare tube and a few tools, " \
    "you can get back on the road in about ten minutes.",
  image_filename: "project_placeholder.jpg",
  features: [
    { title: "Remove the wheel", description: "Open the brake if needed, release the quick-release or axle nuts, and take the wheel off the frame or fork." },
    { title: "Deflate and remove the old tube", description: "Let out any remaining air, use tire levers to pry one side of the tire off the rim, and pull out the punctured tube." },
    { title: "Check the tire for debris", description: "Run a finger carefully along the inside of the tire to feel for the thorn, glass, or debris that caused the flat, and remove it." },
    { title: "Insert the new tube", description: "Partially inflate the new tube so it holds its shape, tuck it inside the tire, and seat the valve through the rim hole." },
    { title: "Reseat the tire and inflate", description: "Push the tire bead back onto the rim by hand, check that the tube isn't pinched anywhere, then inflate to the recommended pressure." },
    { title: "Reinstall the wheel", description: "Put the wheel back on the bike, close the quick-release or tighten the axle nuts, and reset the brake." }
  ],
  technologies: [ "Ruby on Rails", "PostgreSQL", "Tailwind CSS" ]
)

seed_project(
  slug: "how-to-do-a-handstand",
  title: "How to Do a Handstand",
  description: "A freestanding handstand builds incredible body awareness and shoulder strength. " \
    "Start against a wall and work your way up to balancing on your own.",
  image_filename: "example.jpg",
  features: [
    { title: "Warm up your wrists and shoulders", description: "Do wrist circles, wrist stretches, and shoulder rolls to prepare your joints for bearing your full body weight." },
    { title: "Practice against a wall", description: "Face away from a wall, walk your feet up it until your body forms a straight line, and get comfortable being upside down." },
    { title: "Find your stacked alignment", description: "Press firmly through your fingertips, engage your core, and stack your shoulders, hips, and ankles in one vertical line." },
    { title: "Kick up with control", description: "Move to open floor and practice kicking up one leg at a time, using a soft, controlled kick rather than a jump." },
    { title: "Balance and hold", description: "Make small adjustments with your fingers to stay balanced, and focus on a fixed point on the floor to hold the position longer." }
  ],
  technologies: [ "Ruby on Rails", "React" ]
)

seed_project(
  slug: "how-to-make-a-paper-airplane",
  title: "How to Make a Paper Airplane",
  description: "A classic dart-style paper airplane that's simple to fold and flies straight and far. " \
    "Good for a quick break between tasks.",
  image_filename: "project_placeholder.jpg",
  features: [
    { title: "Start with a straight sheet", description: "Use a standard rectangular sheet of paper, oriented with the long edge running away from you." },
    { title: "Fold in half lengthwise", description: "Fold the sheet in half top to bottom, crease firmly, then unfold to leave a center guide line." },
    { title: "Fold the nose triangles", description: "Fold the top two corners in to meet the center line, forming a point at the top." },
    { title: "Fold the point down", description: "Fold the new point down so its tip meets the bottom edge of the triangles, locking them in place." },
    { title: "Fold the wings", description: "Fold the plane in half along the center line, then fold each side down to form the wings." }
  ],
  technologies: [ "Ruby on Rails", "Bootstrap" ]
)

seed_project(
  slug: "how-to-change-a-guitar-string",
  title: "How to Change a Guitar String",
  description: "A snapped or dead string doesn't have to end practice. With a winder and a spare set, " \
    "a restring takes about ten minutes per string.",
  image_filename: "example.jpg",
  features: [
    { title: "Loosen and remove the old string", description: "Turn the tuning peg to release tension, then unwind and pull the string free from the bridge and peg." },
    { title: "Thread the new string", description: "Feed the new string through the bridge (or tie it off, depending on your guitar) and up through the correct tuning peg." },
    { title: "Wind it on", description: "Leave a little slack, then wind the string around the peg with a winder, keeping the wraps neat and going downward." },
    { title: "Bring it up to pitch", description: "Tune the string up gradually, checking pitch often so you don't overshoot and snap it." },
    { title: "Stretch and retune", description: "Gently stretch the string by hand a few times and retune — new strings drop pitch quickly at first." }
  ],
  technologies: [ "Ruby on Rails" ]
)

seed_project(
  slug: "how-to-make-cold-brew-coffee",
  title: "How to Make Cold Brew Coffee",
  description: "Cold brew trades heat for time, steeping overnight for a smooth, low-acid concentrate " \
    "you can dilute however you like.",
  image_filename: "gray.jpeg",
  features: [
    { title: "Coarsely grind the coffee", description: "Use a coarse grind, similar to sea salt, so the coffee doesn't turn muddy during the long steep." },
    { title: "Combine coffee and cold water", description: "Mix coffee and room-temperature or cold water in a jar at roughly a 1:4 ratio for a concentrate." },
    { title: "Steep overnight", description: "Cover and let it steep at room temperature or in the fridge for 12 to 18 hours." },
    { title: "Strain the grounds", description: "Strain through a fine mesh sieve lined with a paper filter or cheesecloth until the liquid runs clear." },
    { title: "Dilute and serve", description: "Cut the concentrate with water or milk to taste, then serve over ice." }
  ],
  technologies: [ "Ruby on Rails", "PostgreSQL" ]
)

seed_project(
  slug: "how-to-set-up-a-standing-desk",
  title: "How to Set Up a Standing Desk",
  description: "A standing desk only helps if it's set up at the right height. Here's how to dial it in " \
    "so it's actually comfortable to use all day.",
  image_filename: "road.jpg",
  features: [
    { title: "Set the desk to elbow height", description: "Stand naturally and raise the desk until the surface lines up with your bent elbows." },
    { title: "Position the monitor", description: "Raise the monitor so the top of the screen sits at or just below eye level, about an arm's length away." },
    { title: "Check your wrists", description: "Adjust the keyboard and mouse height so your wrists stay flat and relaxed, not bent up or down." },
    { title: "Add an anti-fatigue mat", description: "Stand on a cushioned mat to take pressure off your feet and lower back during long stretches." },
    { title: "Alternate sitting and standing", description: "Switch positions every 30 to 60 minutes rather than standing all day — movement matters more than posture alone." }
  ],
  technologies: [ "Ruby on Rails", "Tailwind CSS" ]
)

# Demo blog posts with placeholder images, just to preview the blog layout.
# Safe to re-run — skips any post that already exists.
def seed_post(slug:, title:, body:, image_filename:)
  if Post.exists?(slug: slug)
    puts "Skipping demo post — '#{title}' already exists."
    return
  end

  image_path = Rails.root.join("app/assets/images/placeholders/#{image_filename}")

  post = Post.new(title: title, body: body, published: true)
  post.image.attach(io: File.open(image_path), filename: "#{slug}-cover.jpg", content_type: "image/jpeg")
  post.save!

  puts "Demo post ready: #{title}"
end

seed_post(
  slug: "the-case-for-taking-the-long-way-home",
  title: "The Case for Taking the Long Way Home",
  body: "Every so often I skip the highway and take the back roads instead, even when it adds twenty " \
    "minutes to the drive. There's something about the extra time that resets my head in a way the " \
    "fast route never does.\n\n" \
    "It's not really about the scenery, though the scenery helps. It's that a longer drive forces a " \
    "kind of idle thinking you can't get anywhere else — no podcast, no phone, just the road and " \
    "whatever your brain wants to chew on. Half my best ideas this year showed up somewhere between " \
    "two stoplights I didn't need to hit.\n\n" \
    "So if you're ever debating the quick way versus the long way, and you're not actually in a hurry, " \
    "take the long way. You'll get where you're going eventually, and you might figure something out " \
    "along the way.",
  image_filename: "road.jpg"
)

seed_post(
  slug: "why-i-started-timing-my-coffee-instead-of-my-work",
  title: "Why I Started Timing My Coffee Instead of My Work",
  body: "I used to run a timer for focused work blocks — twenty-five minutes on, five off, the usual. " \
    "It worked fine, but it also made every break feel like it was borrowed time I owed back to the " \
    "timer. So I flipped it: now I only time the coffee.\n\n" \
    "The rule is simple. I make a cup, and however long it takes to drink it while it's actually hot, " \
    "that's my break. No phone, no scrolling, just the cup. When it's empty or lukewarm, I'm back at " \
    "the desk. It turns out that's usually somewhere between eight and twelve minutes, which is close " \
    "enough to what a 'real' break should be, except it doesn't feel like a countdown.\n\n" \
    "It's a small trick, but it changed how breaks feel. A timer measures how much time you're allowed. " \
    "A cup of coffee just tells you when it's done, and somehow that's easier to listen to.",
  image_filename: "gray.jpeg"
)

seed_post(
  slug: "a-short-defense-of-boring-weekends",
  title: "A Short Defense of Boring Weekends",
  body: "For a while I treated every free Saturday like it needed a plan — a hike, an event, a trip " \
    "somewhere, anything to make it count. Eventually I noticed the weekends I actually looked forward " \
    "to all week were the boring ones: laundry, a long lunch, nothing on the calendar.\n\n" \
    "There's a difference between a boring weekend and a wasted one, though it took me a while to see " \
    "it. A wasted weekend is one you don't remember choosing. A boring weekend is one where you " \
    "deliberately chose to do less, and that choice is doing a lot of the work — it's rest you picked " \
    "on purpose, not rest you defaulted into because you ran out of energy for anything else.\n\n" \
    "So now I try to leave at least one weekend a month completely unplanned, on purpose. It's not " \
    "laziness, it's maintenance. Everything else in life runs better after it.",
  image_filename: "road.jpg"
)

seed_post(
  slug: "on-keeping-a-junk-drawer-of-ideas",
  title: "On Keeping a Junk Drawer of Ideas",
  body: "I keep a single text file called ideas.txt. Nothing fancy, no folders, no tags — just a flat " \
    "list that anything is allowed into: a feature idea, a bad pun, a way to phrase a commit message, " \
    "a business idea I'll never build.\n\n" \
    "The rule is that nothing gets judged on the way in. If I stopped to decide whether an idea was " \
    "good enough to write down, I'd stop writing things down, and the whole point is to get it out of " \
    "my head before it evaporates. Sorting happens later, if ever.\n\n" \
    "Most of what's in there will stay junk forever, and that's fine. Every few months something in the " \
    "pile turns out to be exactly what I needed, and I wouldn't have had it if I'd been precious about " \
    "the drawer.",
  image_filename: "gray.jpeg"
)

seed_post(
  slug: "the-two-minute-rule-actually-works",
  title: "The Two-Minute Rule Actually Works",
  body: "The rule is embarrassingly simple: if a task takes less than two minutes, do it now instead of " \
    "adding it to a list. I resisted this for years because it felt too basic to matter.\n\n" \
    "It matters because of what it prevents, not what it accomplishes. A two-minute task that gets " \
    "deferred doesn't stay a two-minute task — it becomes a line on a list, which becomes a thing you " \
    "reread and re-decide about a dozen times before you finally do it. The list is more expensive than " \
    "the task.\n\n" \
    "So now the bar for 'just do it' is lower than my instincts want it to be, and my backlog is smaller " \
    "for it. Not because I'm more productive, but because fewer trivial things ever make it onto the " \
    "list in the first place.",
  image_filename: "example.jpg"
)

seed_post(
  slug: "what-i-learned-debugging-at-2-am",
  title: "What I Learned Debugging at 2 AM",
  body: "The bug only showed up in production, only under load, and only after the deploy I was sure " \
    "had nothing to do with it. By 2 AM I had four tabs of logs open and a theory I'd already disproven " \
    "twice.\n\n" \
    "The fix, when it came, was one line — a race condition in code I'd written months earlier and " \
    "trusted completely. The lesson wasn't really about the bug. It was about how much confidence I'd " \
    "built up in code I hadn't actually re-read in a long time, just because it hadn't broken yet.\n\n" \
    "Now I try to reread old code the way I'd review someone else's pull request: assuming nothing, " \
    "confirming everything. It's slower, but it's a lot cheaper than a 2 AM incident.",
  image_filename: "road.jpg"
)

seed_post(
  slug: "a-case-for-writing-things-down-twice",
  title: "A Case for Writing Things Down Twice",
  body: "When I finish a feature, I write two versions of what happened: the commit message, which is " \
    "for the code, and a short journal entry, which is for me. They almost never say the same thing.\n\n" \
    "The commit message describes what changed. The journal entry describes what was actually hard — " \
    "the wrong turn I took first, the assumption that didn't hold, how it felt to be stuck for an hour " \
    "on something that turned out to be a typo. None of that belongs in git history, but all of it is " \
    "useful to remember.\n\n" \
    "Months later, the commit tells me what I did. The journal entry tells me why it took as long as it " \
    "did, which turns out to be the more useful thing to know the next time I'm stuck.",
  image_filename: "gray.jpeg"
)

seed_post(
  slug: "the-best-meetings-are-the-ones-you-cancel",
  title: "The Best Meetings Are the Ones You Cancel",
  body: "I started asking one question before every recurring meeting I run: does this still need to " \
    "happen this week? Not 'is it useful in general' — specifically, this week, with what's actually " \
    "going on.\n\n" \
    "More often than I expected, the honest answer is no. Nothing's blocked, nothing's changed, and the " \
    "update fits in two sentences of chat instead of thirty minutes of calendar time. Canceling that " \
    "meeting isn't skipping the work, it's noticing the work already happened somewhere else.\n\n" \
    "The meetings that survive that question tend to be better, too — everyone shows up knowing there's " \
    "an actual reason to be there, instead of just because it's Tuesday.",
  image_filename: "example.jpg"
)

seed_post(
  slug: "why-i-stopped-optimizing-my-morning-routine",
  title: "Why I Stopped Optimizing My Morning Routine",
  body: "For a while I had a morning routine with a specific order: water, stretch, journal, read, then " \
    "work. It looked great written down. In practice, missing one step on a rough morning made the " \
    "whole thing feel broken, so I'd just skip the rest.\n\n" \
    "I've since replaced the routine with a much smaller rule: do one good thing before opening a " \
    "laptop. Some days that's a walk. Some days it's just making the bed. It's not optimized, and " \
    "that's exactly why it survives bad mornings instead of collapsing on them.\n\n" \
    "A routine that only works on your best days isn't really a routine, it's a best-case scenario. I'd " \
    "rather have something small that holds up on the worst ones.",
  image_filename: "road.jpg"
)

seed_post(
  slug: "small-rituals-that-make-remote-work-feel-less-lonely",
  title: "Small Rituals That Make Remote Work Feel Less Lonely",
  body: "Working from home solved a lot of problems and quietly introduced a new one: entire days can " \
    "pass without a single unscheduled conversation. No hallway chat, no one stopping by a desk, just " \
    "back-to-back blocks of focused, silent work.\n\n" \
    "A few small rituals have helped more than I expected. Leaving my camera on for the first minute of " \
    "calls instead of joining muted and invisible. Sending a two-line message to a teammate for no " \
    "reason other than curiosity about how their week is going. Taking my coffee break away from the " \
    "desk instead of scrolling next to it.\n\n" \
    "None of it replaces being in a room with people. But it's enough to turn a quiet day into a " \
    "connected one, which is most of what I actually needed.",
  image_filename: "gray.jpeg"
)

# Demo artwork with placeholder images, just to preview the gallery layout.
# Safe to re-run — skips any artwork that already exists.
def seed_artwork(slug:, title:, description:, medium:, year:, image_filename:)
  if Artwork.exists?(slug: slug)
    puts "Skipping demo artwork — '#{title}' already exists."
    return
  end

  image_path = Rails.root.join("app/assets/images/placeholders/#{image_filename}")

  artwork = Artwork.new(title: title, description: description, medium: medium, year: year, published: true)
  artwork.image.attach(io: File.open(image_path), filename: "#{slug}-cover.jpg", content_type: "image/jpeg")
  artwork.save!

  puts "Demo artwork ready: #{title}"
end

seed_artwork(
  slug: "quiet-morning",
  title: "Quiet Morning",
  description: "A study in soft light, painted from a photo taken on a walk before sunrise.",
  medium: "Oil on canvas",
  year: 2023,
  image_filename: "road.jpg"
)

seed_artwork(
  slug: "portrait-study-no-1",
  title: "Portrait Study No. 1",
  description: "An exploration of shadow and form using a limited, warm palette.",
  medium: "Charcoal on paper",
  year: 2024,
  image_filename: "person_placeholder.jpg"
)

seed_artwork(
  slug: "fog-over-the-valley",
  title: "Fog Over the Valley",
  description: "Layers of gray built up slowly to capture a valley disappearing into mist.",
  medium: "Watercolor",
  year: 2024,
  image_filename: "gray.jpeg"
)

seed_artwork(
  slug: "untitled-sketch",
  title: "Untitled Sketch",
  description: "A quick digital sketch made while testing a new brush set.",
  medium: "Digital",
  year: 2025,
  image_filename: "example.jpg"
)

seed_artwork(
  slug: "evening-study",
  title: "Evening Study",
  description: "A quick gouache study chasing the last warm light before it disappeared.",
  medium: "Gouache on paper",
  year: 2023,
  image_filename: "gray.jpeg"
)

seed_artwork(
  slug: "still-life-with-citrus",
  title: "Still Life with Citrus",
  description: "A classic still life setup, mostly an excuse to practice color mixing.",
  medium: "Oil on canvas",
  year: 2024,
  image_filename: "project_placeholder.jpg"
)

seed_artwork(
  slug: "ink-wash-no-3",
  title: "Ink Wash No. 3",
  description: "Third in a series exploring how far a single ink color can be pushed.",
  medium: "Ink wash",
  year: 2024,
  image_filename: "example.jpg"
)

seed_artwork(
  slug: "self-portrait-rough",
  title: "Self Portrait, Rough",
  description: "A loose, fast self portrait done in one sitting without a reference photo.",
  medium: "Pencil on paper",
  year: 2025,
  image_filename: "person_placeholder.jpg"
)

seed_artwork(
  slug: "harbor-at-dusk",
  title: "Harbor at Dusk",
  description: "Painted from memory after an evening walk along the water.",
  medium: "Acrylic on canvas",
  year: 2023,
  image_filename: "road.jpg"
)

seed_artwork(
  slug: "study-in-blue",
  title: "Study in Blue",
  description: "A small color study built entirely from a single hue at different values.",
  medium: "Watercolor",
  year: 2025,
  image_filename: "gray.jpeg"
)
