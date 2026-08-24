INSERT INTO risk_assessment_history
    (risk_id, risk_score, risk_level, assessment_date)
VALUES
    (1, 12, 'Medium',   '2026-01-15'),
    (1, 18, 'High',     '2026-04-15'),
    (1, 25, 'Critical', '2026-07-15'),

    (2, 10, 'Medium',   '2026-02-01'),
    (2, 14, 'Medium',   '2026-05-01'),
    (2, 20, 'High',     '2026-08-01'),

    (3, 8,  'Low',      '2026-01-20'),
    (3, 12, 'Medium',   '2026-04-20'),
    (3, 9,  'Low',      '2026-07-20'),

    (4, 16, 'High',     '2026-02-10'),
    (4, 18, 'High',     '2026-05-10'),
    (4, 22, 'Critical', '2026-08-10'),

    (5, 6,  'Low',      '2026-01-25'),
    (5, 10, 'Medium',   '2026-04-25'),
    (5, 15, 'Medium',   '2026-07-25');